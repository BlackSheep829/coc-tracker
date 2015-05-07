'use strict'

angular.module 'cocApp'
.controller 'LogCtrl', ($scope, $filter, data, ngTableParams, userFactory) ->

    $scope.viewname = data.viewname
    data = data.log

    $scope.tableParams = new ngTableParams
        page: 1,
        count: 25
        filter:
            title: ''
    ,
        total: data.length
        getData: ($defer, params) ->
            orderedData = if params.filter() then $filter('filter')(data, params.filter()) else data
            orderedData = if params.sorting() then $filter('orderBy')(orderedData, params.orderBy()) else orderedData
            params.total(orderedData.length)
            $defer.resolve(orderedData.slice((params.page() - 1) * params.count(), params.page() * params.count()))
    $scope.tableParams.reload()