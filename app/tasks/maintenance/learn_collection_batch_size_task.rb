# frozen_string_literal: true

module Maintenance
  class LearnCollectionBatchSizeTask < MaintenanceTasks::Task
    collection_batch_size(99)

    def collection
      Rails.logger.info("Maintenance::LearnCollectionBatchSizeTask#collection")
      Quote.all
      # Collection to be iterated over
      # Must be Active Record Relation or Array
    end

    def process(element)
      puts "[#{element.id}] #{element.author}: '#{element.content}'"
      # The work to be done in a single iteration of the task.
      # This should be idempotent, as the same element may be processed more
      # than once if the task is interrupted and resumed.
    end

    def count
      # Optionally, define the number of rows that will be iterated over
      # This is used to track the task's progress
      # 75966
      Quote.all.size
    end
  end
end
