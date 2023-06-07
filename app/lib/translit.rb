module Translit
  def self.convert!(text, enforce_language = nil)
    language = if enforce_language
      enforce_input_language(enforce_language)
    else
      detect_input_language(text.split(/\s+/).first)
    end

    map = self.send(language.to_s).sort_by {|k,v| v.length <=>  k.length}
    map.each do |translit_key, translit_value|
      text.gsub!(translit_key.capitalize, translit_value.first)
      text.gsub!(translit_key, translit_value.last)
    end
    text
  end

  def self.convert(text, enforce_language = nil)
    convert!(text.dup, enforce_language)
  end
  def self.translitirate( text, index = "" )

    seo = ::Translit.convert text.downcase.dup, :english
    replace   =[[' ', '-'], ['/', ''], ['.', ''], [',', ''], ["'", ""], ['"', ''], ['&', '-and-']]
    replace.each { |r| seo.gsub! r.first, r.last }
    seo.gsub!(/[а-яА-Я]/, '')
    "#{seo.gsub(/[\u0080-\u00ff]/,'')}#{index}"
  end
private
  def self.create_russian_map
    self.english.inject({}) do |acc, tuple|
      rus_up, rus_low = tuple.last
      eng_value       = tuple.first
      acc[rus_up]  ? acc[rus_up]  << eng_value.capitalize : acc[rus_up]  = [eng_value.capitalize]
      acc[rus_low] ? acc[rus_low] << eng_value            : acc[rus_low] = [eng_value]
      acc
    end
  end

  def self.detect_input_language(text)
    text.scan(/\w+/).empty? ? :russian : :english
  end

  def self.enforce_input_language(language)
    if language == :english
      :russian
    else
      :english
    end
  end

  def self.english
    { "a"=>["А","а"], "b"=>["Б","б"], "w"=>["В","в"],"v"=>["В","в"], "g"=>["Г","г"], "d"=>["Д","д"], "e"=>["Е","е"], "yo"=>["Ё","ё"], "jo"=>["Ё","ё"], "ö"=>["Ё","ё"], "zh"=>["Ж","ж"],
      "z"=>["З","з"], "i"=>["И","и"], "j"=>["Й","й"], "k"=>["К","к"], "l"=>["Л","л"], "m"=>["М","м"], "n"=>["Н","н"], "o"=>["О","о"], "p"=>["П","п"], "r"=>["Р","р"],
      "s"=>["С","с"], "t"=>["Т","т"], "u"=>["У","у"], "f"=>["Ф","ф"], "h"=>["Х","х"], "x"=>["Кс","кс"], "ts"=>["Ц","ц"], "ch"=>["Ч","ч"], "sh"=>["Ш","ш"],
      "shch"=>["Щ","щ"], "sch"=>["Щ","щ"], "#"=>["Ъ","ъ"], "y"=>["Ы","ы"], ""=>["Ь","ь"], "je"=>["Э","э"], "ä"=>["Э","э"], "yu"=>["Ю","ю"], "ju"=>["Ю","ю"],
      "ü"=>["Ю","ю"], "ya"=>["Я","я"], "ja"=>["Я","я"], "q"=>["Я","я"],"i"=>['І','і'],"i-"=>['Ї','ї'], 'ґ'=>['G','g']}
  end

  def self.switch_lang_en_ru(str)
    resstr = str.dup
    switch_ru_hash = {'q'=>'й','w'=>'ц','e'=>'у','r'=>'к','t'=>'е','y'=>'н','u'=>'г','i'=>'ш','o'=>'щ','p'=>'з','['=>'х',']'=>'ъ','a'=>'ф','s'=>'ы','d'=>'в','f'=>'а','g'=>'п','h'=>'р','j'=>'о','k'=>'л','l'=>'д',';'=>'ж',"'"=>'э','z'=>'я','x'=>'ч','c'=>'с','v'=>'м','b'=>'и','n'=>'т','m'=>'ь',','=>'б','.'=>'ю','/'=>'.'}
    switch_ru_hash.each {|k,v| resstr.gsub!(k,v)}
    resstr
  end

  def self.switch_lang_en_uk(str)
    resstr = str.dup
    switch_uk_hash = {'q'=>'й','w'=>'ц','e'=>'у','r'=>'к','t'=>'е','y'=>'н','u'=>'г','i'=>'ш','o'=>'щ','p'=>'з','['=>'х',']'=>'ї','a'=>'ф','s'=>'і','d'=>'в','f'=>'а','g'=>'п','h'=>'р','j'=>'о','k'=>'л','l'=>'д',';'=>'ж',"'"=>'є','z'=>'я','x'=>'ч','c'=>'с','v'=>'м','b'=>'и','n'=>'т','m'=>'ь',','=>'б','.'=>'ю','/'=>'.'}
    switch_uk_hash.each {|k,v| resstr.gsub!(k,v)}
    resstr
  end

  def self.russian
    @russian ||= create_russian_map
  end
end
