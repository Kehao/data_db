#encoding: utf-8
module ApplicationHelper

  def contact_attrs
    [:reg_address, :reg_zip, :opt_address, :opt_zip, :zone, :industry, :tel, :fax, :email]
  end

  def changes1_attrs
    [:change_at, :name, :before_amount, :before_percent, :after_amount, :after_percent]
  end

  def changes2_attrs
    [:change_at, :event, :before, :after]
  end

  def owner_attrs
    [:category, :name, :sex, :birthday, :number, :education, :position, :address, :zip, :cv, :negative]
  end

  def new_or_edit_credit(company)
    if company.credit
      [:edit,company.credit]
    else
      new_credit_path(:company_id=>company.id) 
    end
  end

  def industry_select_options
    Industry.where(:id=>[100..119]).all.map do |industry|
      {"value" => industry.id,"text"=> industry.name}
    end
  end

  def editable_link(model,attr,data_url,data_type="text",data_value=nil)
    model_name = model.class.name.downcase
    attr_name = model.class.human_attribute_name(attr) 
    view_css_class = "#{model_name}_#{attr}"

    link_to (model && model.public_send(attr) || ""),"#",
      :class=>"#{model_name}_editable #{view_css_class} editable editable-click editable-empty",
      :'data-type'=> data_type,
      :'data-url'=> data_url,
      :'data-original-title'=>"修改#{attr_name}",
      :'data-resource'=> model_name,
      :'data-name'=> attr,
      :'data-value' => data_value 
  end

  def text_editable_link(model,attr,data_url)
    editable_link(model,attr,data_url)
  end
end
