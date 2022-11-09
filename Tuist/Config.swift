import ProjectDescription

let config = Config(
    cache: .cache(
        profiles: [
            .profile(name: "Develop", configuration: "DevelopIntegration"),
        ]
    )
)
