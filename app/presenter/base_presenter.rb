@@ -0,0 +1,13 @@
class BasePresenter
  def initialize obj
    @obj = obj
  end

   def as_json
    obj.as_json.except("")
  end

   private

   attr_reader :obj
end