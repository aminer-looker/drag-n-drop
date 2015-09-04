#
# Copyright (C) 2015 by Looker Data Services, Inc.
# All rights reserved.
#

angular = require 'angular'
templates = require '../templates'

############################################################################################################

grid = angular.module 'grid', []

grid.controller 'GridController', class GridController

    RETURN_KEYCODE = 13

    constructor: ($scope)->
        @items = [
            {
                type:'text', sizeX:2, sizeY:1, row:0, col:0, text:"""
                    Maecenas non eros ut orci maximus fringilla commodo non ipsum. Curabitur elit felis,
                    pulvinar ac lacus ac, interdum auctor ex.
                """
            }, {
                type:'image', sizeX:2, sizeY:1, row:0, col:2, url:
                    'http://www.geararium.org/Antique%20gear%20pattern%202283.jpg'
            }, {
                type:'image', sizeX:2, sizeY:1, row:0, col:4, url:'http://www.geararium.org' +
                    '/Antique%20gear,%20cog%20pattern%20with%20Y-shaped%20spokes%20770%20mm.jpg'
            }, {
                type:'image', sizeX:4, sizeY:3, row:1, col:0, url:
                    'http://geararium.org/Antique%20gear%20pattern%20130.jpg'
            }, {
                type:'image', sizeX:2, sizeY:1, row:1, col:4, url:'http://img.indiabizsource.com' +
                    '/sites/default/files/products/image/1008689/windmill.jpg'
            }, {
                type:'text', sizeX:2, sizeY:1, row:2, col:4, text:"""
                    Curabitur fringilla volutpat accumsan. Pellentesque bibendum vitae massa iaculis
                    dapibus. Vestibulum vulputate consectetur neque, et fringilla augue dictum vitae.
                    Mauris nec erat quis tellus bibendum luctus lobortis tristique augue. Donec volutpat,
                    ligula placerat luctus luctus, magna nisl placerat ex, at eleifend elit dui quis eros.
                    Integer lorem ligula, rutrum et erat vitae, placerat luctus ante.
                """
            }, {
                type:'text', sizeX:2, sizeY:1, row:3, col:4, text:"""
                    Nullam id mollis tortor, eu euismod eros. Curabitur ac venenatis diam. In suscipit
                    magna quis augue tincidunt, sed consequat metus sodales. Nulla facilisi. Aenean varius,
                    lacus vitae congue porta, nibh ligula iaculis massa, ut egestas mauris sapien id purus.
                """
            }
        ]

        @gridsterOptions =
            columns: 6
            swapping: true
            width: 'auto'
            rowHeight: 160
            margins: [20, 20]
            outerMargin: false
            resizable:
                enabled: true
                handles: [ 'se' ]
            draggable:
                enabled: true

    onKeyUp: (event)->
        if event.keyCode is RETURN_KEYCODE
            event.target.blur()

grid.directive 'gridItem', ($compile)->
    refresh = (scope, element)->
        type = scope.item?.type
        return unless scope.item? and type?

        if type is 'text'
            scope.text = scope.item.text
            element.html templates['grid_text']
        else if type is 'image'
            scope.url = scope.item.url
            element.html templates['grid_image']

        $compile(element.contents())(scope)

    link = (scope, element)->
        scope.$watch (-> scope.item), (-> refresh scope, element)
        refresh scope, element

    return {
        restrict: 'E'
        link: link
        scope:
            item: '='
    }
