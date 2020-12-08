variable "auth_pm" {
    type                = object({
        host            = string
        user            = string
        pass            = string
        insecure        = bool
    })
    default             = {
            host        = "127.0.0.1"
            user        = "root@pam"
            pass        = ""
            insecure    = "true"
    }
    #sensitive           = true
}

variable "pm" {
    type                = object({
        node            = string
        template        = string
        storage_ssd     = string
        storage_base    = string
        net_server      = string
    })
    default             = {
        node            = "ether"
        template        = "ubuntu-20.04"
        storage_ssd     = "ssd-lvm"
        storage_base    = "10G"
        net_server      = "vmbr4"
    }
}