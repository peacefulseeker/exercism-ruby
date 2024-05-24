class Atbash
  ALPHA = ('a'..'z').to_a

  def self.encode(plaintext)
    # encoded = plaintext.downcase.scan(/[a-z0-9]/).join.gsub(/[a-z]/) { |c| ALPHA[CIPHER.index(c)] }
    # encoded.chars.each_slice(5).map(&:join).join(' ')

    decode(plaintext).scan(/.{1,5}/).join(' ')
  end

  def self.decode(text)
    # ciphertext.downcase.scan(/[a-z0-9]/).join.gsub(/[a-z]/) { |c| CIPHER[ALPHA.index(c)] }
    text.downcase.gsub(/\W/, '').tr('a-z', ALPHA.reverse.join)
  end
end

# https://exercism.org/tracks/ruby/exercises/atbash-cipher/solutions/jcreiff
class AtbashTranslate
  ALPHA = ('a'..'z').to_a.join
  def self.encode(text)
    decode(text).chars.each_slice(5).map(&:join).join(' ')
  end

  def self.decode(text)
    text.downcase.gsub(/\W/, '').tr('a-z', ALPHA.reverse)
  end
end

# https://exercism.org/tracks/ruby/exercises/atbash-cipher/solutions/fpsvogel
module AtbashScan
  def self.encode(str)
    str.downcase
       .tr('^a-z0-9', '')
       .tr('a-z', Array('a'..'z').reverse.join)
       .scan(/.{1,5}/)
       .join(' ')
  end

  def self.decode(str)
    str.gsub(' ', '')
       .tr('a-z', Array('a'..'z').reverse.join)
  end
end
