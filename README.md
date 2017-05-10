Spiti Jenkins
=============

Setup
-----
1. Create private ssh Github key file `id_rsa` and add it to `~/.ssh/`
  (enable jenkins to commit)
2. Add Slack `Integration Token` (`<token></token>`) to `jenkins.plugins.slack.SlackNotifier.xml`
  (enable jenkins to send notification in Slack