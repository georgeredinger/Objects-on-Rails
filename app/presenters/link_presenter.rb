class LinkPresenter < Presenter
  RELATIONS = %w[next prev up]

  def prev_url
    @template.url_for(prev)
  end

  def next_url
    @template.url_for(self.next)
  end

  def up_url
    @template.url_for(up)
  end

  def links_hash
    {
      "links" => RELATIONS.map { |rel|
        {"rel" => rel, "href" => send("#{rel}_url")}
      }
    }
  end

  def serializable_hash(*args)
    super.merge(links_hash)
  end

  def to_json(options={})
    serializable_hash(options).to_json
  end
end

