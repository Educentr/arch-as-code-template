class Styler {
    String proj = "";
    String REGEX_VIEW = /^(\w+[_-]\d+).*/;
    String REGEX_SKIP_CLASS = /^class com\.structurizr\.model\.(?:Component|Person)$/;
    def printErr = System.err.&println
    def ApplyStyle(it) {
        if (it.getClass() =~ REGEX_SKIP_CLASS) {
            return;        
        }

        String[] tags = it.getTags().split(",")
        String style = ""
        Boolean foundProjTag = false
        
        for (String t in tags) {
            if (t =~ REGEX_VIEW) {
                if (!foundProjTag) {
                    if (t == proj) {
                        style = "NEW";
                        foundProjTag = true;
                    }
                } else {
                    style = "MOD"
                    break;
                }
            } else if (foundProjTag && t == "NOT_MODIFIED") {
                style = "";
                break;
            }
        }

        if (style != "") {
            it.addTags(style)
            printErr("Add style: `" + style + "` for `" + it.getClass() + "`: `" + it + '`')
        }
    }

    public Styler() {
        printErr("Branch name: " + System.getenv('BRANCH_NAME'))
        def matcher = System.getenv('BRANCH_NAME') =~ REGEX_VIEW;
        if (matcher.matches()) {
            proj = matcher[0][1]
        }
        printErr("Detect proj for colorize: " + proj)
    }
}

s = new Styler();
if (s.proj != "") {
    workspace.getModel().getElements().each {
        s.ApplyStyle(it)
    }
    workspace.getModel().getRelationships().each {
        s.ApplyStyle(it)
    }
}
