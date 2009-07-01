module StringExtensions
  def numeric?; !self.match(/\A\-?\d+(\.\d+)?\Z/).nil? end
  def date?; !self.match(/\A\d?\d\/\d?\d(\/\d{2,4})?\Z/).nil? end
  def time?; !self.downcase.match(/\d+(:|am|pm)\d*/).nil? end
  
  def typed(ref = nil)
    case
      when numeric?;  self.to_f
      when date?;     Chronic.parse(self.split("/").reverse.join("-")).try(:to_date)
      when time?;     Chronic.parse("#{ref} #{self}")
      else            self.downcase
    end
  end
end