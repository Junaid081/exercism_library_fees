defmodule LibraryFees do
  def datetime_from_string(string) do
    NaiveDateTime.from_iso8601!(string)
  end

  def before_noon?(datetime) do
   time = datetime
    if time.hour < 12 do
      true
    else
     false
    end
  end

  def return_date(checkout_datetime) do
    time = checkout_datetime
    if time.hour < 12 do
    returndate = NaiveDateTime.add(checkout_datetime, 28, :day)
    NaiveDateTime.to_date(returndate)
    else
    returndate = NaiveDateTime.add(checkout_datetime, 29, :day)
    NaiveDateTime.to_date(returndate)
    end
  end

  def days_late(planned_return_date, actual_return_datetime) do
    actual_return_datetime = NaiveDateTime.to_date(actual_return_datetime)
   check= Date.diff(actual_return_datetime, planned_return_date)
    if check > 0 do
      check
    else 
      0
    end
  end

  def monday?(datetime) do
    value = NaiveDateTime.to_date(datetime)
    value = Date.day_of_week(value, :monday)
    if value == 1 do
      true
    else
    false
    end
  end

  def calculate_late_fee(checkout, return, rate) do
      checkout_value = datetime_from_string(checkout)
      checkout_value = return_date(checkout_value)
      
      actual_return_value = datetime_from_string(return)
      actual_return_datetime = NaiveDateTime.to_date(actual_return_value)
     
      check= Date.diff(actual_return_datetime, checkout_value)
        
      if check > 0 do
        value = rate * check
        if monday?(actual_return_value) do
            value = trunc(value * 0.5)
          else
            value
        end
      else
        0
      end
  end

end
