module StringExtensions
  def numeric?; !self.match(/\A\-?\d+(\.\d+)?\Z/).nil? end
  def date?; !self.match(/\A\d?\d\/\d?\d(\/\d{2,4})?\Z/).nil? end
  
  def typed
    if numeric?;  to_f
    elsif date?;  Chronic.parse(self)
    else;         self
    end
  end
end