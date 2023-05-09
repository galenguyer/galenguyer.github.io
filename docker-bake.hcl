variable "REGISTRY" {
    default = "local"
}

group "default" {
    targets = ["image"]
}

target "image" {
    tags = [
        "${REGISTRY}/galenguyer.com"
    ]
}

target "files" {
    target = "files"
    output = ["_site"]
}
