PaperTrail.config.enabled = true
# Only log the update and destroys
PaperTrail.config.has_paper_trail_defaults = {
  on: %i[update destroy]
}
# Unlimited audits ...
PaperTrail.config.version_limit = nil
