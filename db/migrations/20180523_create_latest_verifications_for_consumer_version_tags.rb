require_relative "../ddl_statements"

Sequel.migration do
  up do
    create_view(:latest_verification_ids_for_consumer_version_tags, LATEST_VERIFICATION_IDS_FOR_CONSUMER_VERSION_TAGS_V1)

    # The most recent verification for each consumer/consumer version tag/provider
    latest_verifications = from(:verifications)
      .select(
        Sequel[:lv][:consumer_id],
        Sequel[:lv][:provider_id],
        Sequel[:lv][:consumer_version_tag_name],
        Sequel[:pv][:sha].as(:pact_version_sha),
        Sequel[:prv][:number].as(:provider_version_number),
        Sequel[:prv][:oorder].as(:provider_version_order),
        )
      .select_append{ verifications.* }
      .join(:latest_verification_ids_for_consumer_version_tags,
        {
          Sequel[:verifications][:id] => Sequel[:lv][:latest_verification_id],
        }, { table_alias: :lv })
      .join(:versions,
        {
          Sequel[:verifications][:provider_version_id] => Sequel[:prv][:id]
        }, { table_alias: :prv })
      .join(:pact_versions,
        {
          Sequel[:verifications][:pact_version_id] => Sequel[:pv][:id]
        }, { table_alias: :pv })

    create_or_replace_view(:latest_verifications_for_consumer_version_tags, latest_verifications)
  end

  down do
    drop_view(:latest_verifications_for_consumer_version_tags)
    drop_view(:latest_verification_ids_for_consumer_version_tags)
  end
end
