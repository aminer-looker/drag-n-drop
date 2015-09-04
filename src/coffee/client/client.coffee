#
# Copyright (C) 2015 by Looker Data Services, Inc.
# All rights reserved.
#

angular = require 'angular'

############################################################################################################

# Allow Node.js-style `global` in addition to `window`
if typeof(global) is 'undefined'
    window.global = window

# Add 'require' statements for your other Angular module files here.
require './modules/grid'
require 'angular-gridster'

# Add all your modules here.
app = angular.module 'app', [
    'grid'
    'gridster'
]

console.log "client is ready"
