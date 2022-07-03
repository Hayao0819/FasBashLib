#!/usr/bin/env bash

Admin.ServerInfo(){
    @BindingBase "/admin/server-info" -- "$@"
}
