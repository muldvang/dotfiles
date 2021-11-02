#!/usr/bin/env sh

echo '*Definition of Done (not BioX)*
|| Item || Description || Done by || Reviewed by || Notes ||
| SDS | In Polarion or RST format |  |  | <Polarion ID(s) if available> |
| Test spec | BDD scenarios in feature files or manual test cases in Polarion |  |  |  |
| Test impl | Test driver code for BDD scenarios |  |  |  |
| Code | If no Crucible review, state how the code was reviewed |  |  |  |
| DDS | Word or Javadoc |  |  |  |
| Risk identification | Can the chosen design cause wrong or delayed results? |  | NA | If risk is identified, note finding here, else note "No risk identified" |
| Impact identification | Does the chosen design have the desired impact on other concurrently developed projects? |  | NA | If undesired impact is identified, create new Jira issue and note reference, else note "No undesired impact identified" |' | xsel -b

xdotool key --clearmodifiers shift+Insert
