def init
  super
  sections.push :steptransformers, [:stepdefinitions, :steptransforms]
end


def stepdefinitions
  @item_title = "Step Definitions"
  @item_type = "step definition"
  @items = YARD::Registry.all(:stepdefinition)
  erb(:transformers)
end

def steptransforms
  @item_title = "Step Transformers"
  @item_type = "step transformer"
  @items = YARD::Registry.all(:steptransform)
  erb(:transformers)
end


def link_transformed_step(step)
  value = "#{step.keyword}#{step.value}"
  
  if step.transformed?
    step.value.match(%r{#{step.definition.compare_value}}).to_a.each do |match|
      step.transforms.each do |transform|
        value.gsub!(match,"<a href='#{url_for(transform)}'>#{match}</a>") if %r{#{transform.compare_value}}.match(match)
      end
    end
  end

  value
end