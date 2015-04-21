namespace 'Views.Home'

class Views.Home.Show
  constructor: (@$container) ->
    self = this

    @$container.find('@addToCart').on('click'
      (e) ->
        $target = $(e.target)
        self.send_request(Routes.add_cart_path(), {id: $target.data('id'), count: $target.data('count')}, {requestType: 'POST', dataType: 'json'})
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
