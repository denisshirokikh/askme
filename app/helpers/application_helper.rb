module ApplicationHelper
  # Этот метод возвращает ссылку на аватарку пользователя, если она у него есть.
  # Или ссылку на дефолтную аватарку, которую положим в app/assets/images
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_pack_path 'media/images/logo.png'
    end
  end

  def word_inclination(number, one, few, many)
    special_case_number = number % 100
    case_last_number = number % 10
    if [0, 5, 6, 7, 8, 9].include?(case_last_number) ||
      (11..14).include?(special_case_number)
      return many
    end
    return few if [2,3,4].include?(case_last_number)
    return one
  end

  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end
end