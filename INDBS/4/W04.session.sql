-- 1. Create a view AllAccountRecords that joins the Accounts and AccountRecords and shows one entry for each record for each account. The view should show all columns from both tables, first Accounts and then AccountRecords, except the AccountRecords.AID column. Accounts with no entry in AccountRecords should be shown with NULLs in the columns for AccountRecords.
CREATE VIEW AllAccountRecords AS
SELECT
    accounts.aid, 
    pid, adate, 
    abalance, 
    aover, 
    rid, 
    rdate, 
    rtype, 
    ramount, 
    rbalance
 FROM accounts
LEFT OUTER JOIN accountrecords
ON accounts.aid = accountrecords.aid;
SELECT * FROM allaccountrecords;

-- 2. Create a trigger CheckBills for insertions to Bills that enforces a) that the amount must be non-negative, and b) that the due date must be in the future (tomorrow or later).
-- Optional: Forbid DELETE operations and allow UPDATE only on the pIsPaid attribute. This is reflected in the test script.
CREATE FUNCTION CheckBills()
RETURNS TRIGGER
AS $$ BEGIN
    IF (TG_OP = 'INSERT') THEN
        IF (NEW.bamount < 0) THEN
            RAISE EXCEPTION
                'bro how can you have a negative bill???'
            USING ERRCODE = '45000';
        END IF;
        IF (NEW.bduedate <= NOW()) THEN
            RAISE EXCEPTION
                'literally time travel'
            USING ERRCODE = '45001';
        END IF;
    END IF;
    IF (TG_OP = 'DELETE') THEN
        RAISE EXCEPTION
            'dont try to delete that shit'
        USING ERRCODE = '45002';
    END IF;
    IF (TG_OP = 'UPDATE') THEN
        IF (
            NEW.bid != OLD.bid OR
            NEW.pid != OLD.pid OR
            NEW.bduedate != OLD.bduedate OR
            NEW.bamount != OLD.bamount
        ) THEN
            RAISE EXCEPTION
                'if you wanna change something then pay the fucking thing'
            USING ERRCODE = '45003';
        END IF;
    END IF;
    RETURN NEW;
END; $$ LANGUAGE plpgsql;
CREATE TRIGGER CheckBills
BEFORE INSERT OR DELETE OR UPDATE
ON bills
FOR EACH ROW EXECUTE PROCEDURE CheckBills();

-- 3. Create a trigger on the AccountRecords table that does the following for each insertion: a) checks whether the amount is available (taking the overdraft into account) on the account being withdrawn from, b) updates the balance on the account and c) installs the correct balance into the AccountRecords entry.
-- Optional: Forbid DELETE and UPDATE operations. This is reflected in the test script.
CREATE OR REPLACE FUNCTION ValidateAccoundRecord()
RETURNS TRIGGER
AS $$
DECLARE
    abal INTEGER;
    aov INTEGER;
    newbal INTEGER;
BEGIN
    IF (TG_OP = 'INSERT') THEN
        BEGIN
            SELECT abalance, aover INTO abal, aov
            FROM accounts
            WHERE accounts.aid = NEW.aid;
        END;
        newbal = abal + NEW.ramount;
        IF (newbal < -aov) THEN
            RAISE EXCEPTION
                'you poor 💀 homeless ass 💸'
            USING ERRCODE = '44999';
        END IF;
        BEGIN
            UPDATE accounts
            SET abalance = accounts.abalance + NEW.ramount
            WHERE accounts.aid = NEW.aid;
        END;
        BEGIN
            NEW.rbalance := newbal;
        END;
    END IF;
    IF (TG_OP = 'DELETE' ) THEN
        RAISE EXCEPTION
            'dont try to delete that shit'
        USING ERRCODE = '45002';
    END IF;
    IF (TG_OP = 'UPDATE') THEN
        RAISE EXCEPTION
            'no updates amigo'
        USING ERRCODE = '45003';
    END IF;
    RETURN NEW;
END; $$ LANGUAGE plpgsql;
CREATE OR REPLACE TRIGGER ValidateAccoundRecord
BEFORE INSERT OR DELETE OR UPDATE
ON accountrecords
FOR EACH ROW EXECUTE PROCEDURE ValidateAccoundRecord();

-- 4. Create a procedure Transfer, which takes three parameters, iToAID, iFromAID, and iAmount, and transfers the given amount between the two given accounts in a single transaction. If the amount is not available in the iFromAID  account,  then  the  operation  should  be  aborted  (this  should happen via the trigger from #3). No return value. Optional:  Ensure  that  the  transfer  is  non-negative.  This  is  reflected  in  the test script.
CREATE OR REPLACE FUNCTION Transfer(
    iToAID INT,
    iFromAID INT,
    iAmount INT
)
RETURNS void AS
$$
BEGIN
    INSERT INTO accountrecords (aid, rdate, rtype, ramount)
    VALUES (iFromAID, NOW(), 'T', -iAmount);
    INSERT INTO accountrecords (aid, rdate, rtype, ramount)
    VALUES (iToAID, NOW(), 'T', iAmount);
RETURN;
END;
$$ LANGUAGE plpgsql;

-- 5. Create a view DebtorStatus that shows, for each person whose total balance is less than 0, the PID and pName of the person, the total  balance of all their accounts, and the total overdraft of all their accounts.
-- CREATE VIEW DebtorStatus(
--     PID, pName, pBalance, pOverdraft
-- )
-- AS 
-- SELECT people.pid, pname, SUM(abalance), SUM(aover) FROM people
-- JOIN accounts ON accounts.pid = people.pid
-- GROUP BY people.pid
-- HAVING SUM(abalance) < 0;