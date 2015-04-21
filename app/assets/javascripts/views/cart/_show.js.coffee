namespace 'Views.Cart'

class Views.Cart.Show
  constructor: (@$container) ->
    self = this

    @$container.find('@productCount').off('change').on('change'
      (e) ->
        $count = $(e.target)
        self.send_request(Routes.cart_path(), {id: $count.data('id'), count: $count.val()}, {requestType: 'PATCH', dataType: 'json'})
    )

  send_request: (url, data, options) ->
    self = this

    $.ajax(
      type: options.requestType
      dataType: options.dataType
      url: url
      data: data if data?
    ).done(
      (data) ->
        $('@fullPrice').text(data.full_price)
        $('@fullCount').text(data.full_count)
        $('@fullCountText').text(data.text)
    ).fail(
      (data) ->
    )
