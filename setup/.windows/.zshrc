_after() {
    # use notification script
    # TODO: automatically run appropriate setup scripts for detected OS
    # TODO: automatically install configuration + script (when on windows)
    # TODO: pass subject, details
    powershell -f ~/.config/walterjwhite/console "<SUBJECT>" "<DETAILS>"
}