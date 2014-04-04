module ApplicationHelper
  FLASH_CLASSES = {
    alert: "danger",
    error: "danger",
    notice: "success",
  }.with_indifferent_access.freeze

  def flash_class(name)
    FLASH_CLASSES[name] || name
  end

  def navbar_list_item(text, options={})
    return if options.delete(:hide)
    render 'navbar_list_item', text: text, path: yield, options: options
  end
end
