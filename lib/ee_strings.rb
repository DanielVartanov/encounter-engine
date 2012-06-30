class String
  def upcase_utf8_cyr
    s = self.upcase
    ar = s.chars.map do |ch|
      case ch
        when "а" : "А"
        when "б" : "Б"
        when "в" : "В"
        when "г" : "Г"
        when "д" : "Д"
        when "е" : "Е"
        when "ё" : "Ё"
        when "ж" : "Ж"
        when "з" : "З"
        when "и" : "И"
        when "й" : "Й"
        when "к" : "К"
        when "л" : "Л"
        when "м" : "М"
        when "н" : "Н"
        when "о" : "О"
        when "п" : "П"
        when "р" : "Р"
        when "с" : "С"
        when "т" : "Т"
        when "у" : "У"
        when "ф" : "Ф"
        when "х" : "Х"
        when "ц" : "Ц"
        when "ч" : "Ч"
        when "ш" : "Ш"
        when "щ" : "Щ"
        when "ы" : "Ы"
        when "ъ" : "Ъ"
        when "ы" : "Ы"
        when "ь" : "Ь"
        when "э" : "Э"
        when "ю" : "Ю"
        when "я" : "Я"
        else ch
      end
    end

    ar.join
  end
end
