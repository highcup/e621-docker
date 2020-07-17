module TakedownsHelper
  def pretty_takedown_status(takedown)
    status = takedown.pretty_status
    classes = {'inactive' => 'sect_grey',
               'denied' => 'sect_red',
               'partial' => 'sect_green',
               'approved' => 'sect_green'}
    tag.td(status, class: classes[takedown.status])
  end
end
