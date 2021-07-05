variable "REGISTRY" {
    default = "local"
}

group "default" {
    targets = ["image"]
}

target "image" {
    dockerfile = "Dockerfile"
    tags = [
        "${REGISTRY}/galenguyer.com"
    ]
}

target "files" {
    dockerfile = "Dockerfile.files"
    target = "final"
    output = ["_site"]
}
