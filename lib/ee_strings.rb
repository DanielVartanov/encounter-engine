# -*- encoding : utf-8 -*-
class String
  def upcase_utf8_cyr
    UnicodeUtils.upcase(self)
  end
end
