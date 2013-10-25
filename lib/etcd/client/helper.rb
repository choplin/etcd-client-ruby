module Etcd
  module Client
    module Helper
      def handle_error(res)
        json = JSON.parse(res.body)
        case json['errorCode']
        when 100
          raise KeyNotFoundError
        when 101
          raise TestFailedError
        when 102
          raise NotFileError
        when 103
          raise NoMoreMachineError
        when 104
          raise NotDirError
        when 105
          raise NodeExistError
        when 106
          raise KeyIsPreservedError

        when 200
          raise ValueRequiredError
        when 201
          raise PrevValueRequiredError
        when 202
          raise TTLNaNError
        when 203
          raise IndexNaNError
        when 204
          raise ValueOrTTLRequiredError

        when 300
          raise RaftInternalError
        when 301
          raise LeaderElectError

        when 400
          raise WatcherClearedError
        when 401
          raise EventIndexClearedError
        end
      end
    end
  end
end
