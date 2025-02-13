
from machamp.modules.allennlp.conditional_random_field import ConditionalRandomField, allowed_transitions

def init:
    constraints = allowed_transitions('BIO', vocabulary.inverse_namespaces[task])
    self.crf_layer = ConditionalRandomField(
        nlabels, constraints
    )

def forward:
    mlm_out = self.mlm(input)
    logits = self.hidden_to_label(mlm_out)
    best_paths = self.crf_layer.viterbi_tags(logits, mask)



