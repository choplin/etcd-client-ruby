module Etcd
  module Client
    class KeyNotFoundError < StandardError; end
    class TestFailedError < StandardError; end
    class NotFileError < StandardError; end
    class NoMoreMachineError < StandardError; end
    class NotDirError < StandardError; end
    class NodeExistError < StandardError; end
    class KeyIsPreservedError < StandardError; end

    class ValueRequiredError < StandardError; end
    class PrevValueRequiredError < StandardError; end
    class TTLNaNError < StandardError; end
    class IndexNaNError < StandardError; end
    class ValueOrTTLRequiredError < StandardError; end

    class RaftInternalError < StandardError; end
    class LeaderElectError < StandardError; end

    class WatcherClearedError < StandardError; end
    class EventIndexClearedError < StandardError; end
  end
end
