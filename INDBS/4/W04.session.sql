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
CREATE FUNCTION ValidateAccoundRecord()
RETURNS TRIGGER
AS $$ BEGIN
    IF (TG_OP = 'INSERT') THEN
        DECLARE abal INTEGER;
        DECLARE aov INTEGER;
        DECLARE newbal INTEGER;
        BEGIN
            SELECT abalance, aover, abalance + NEW.ramount INTO abal, aov, newbal
            FROM accounts
            WHERE accounts.aid = NEW.aid;
        END;
        IF (-NEW.ramount > abal + aov) THEN
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
CREATE TRIGGER ValidateAccoundRecord
BEFORE INSERT OR DELETE OR UPDATE
ON accountrecords
FOR EACH ROW EXECUTE PROCEDURE ValidateAccoundRecord();
