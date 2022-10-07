return {
    settings = {
        yaml = {
            schemas = {
                -- "": ["*/helm/**/*.yaml"],
                ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "/.gitlab-ci.yaml",
            }
        }
    }
}
