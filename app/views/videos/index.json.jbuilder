json.array!(@videos) do |video|
  json.extract! video, :id, :hyperlink, :position, :link_text
  json.url video_url(video, format: :json)
end
