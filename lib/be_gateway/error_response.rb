module BeGateway
  class ErrorResponse < OpenStruct
    def initialize(response)
      super(response.body)
    end

    def invalid?
      true
    end

    def errors
      @errors ||= Errors.new(self[:errors])
    end

    private

    attr_reader :params

    class Errors < OpenStruct
      def attributes
        each_pair.collect {|attr, _| attr }
      end

      def on(attribute)
        self[attribute]
      end

      def for(attribute)
        Errors.new(self[attribute])
      end
    end
  end
end
