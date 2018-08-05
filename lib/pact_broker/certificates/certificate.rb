module PactBroker
  module Certificates
    class Certificate < Sequel::Model
    end

    Certificate.plugin :timestamps, update_on_create: true
  end
end

# Table: certificates
# Columns:
#  id          | integer                     | PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY
#  uuid        | text                        | NOT NULL
#  description | text                        |
#  content     | text                        | NOT NULL
#  created_at  | timestamp without time zone | NOT NULL
#  updated_at  | timestamp without time zone | NOT NULL
# Indexes:
#  certificates_pkey   | PRIMARY KEY btree (id)
#  uq_certificate_uuid | UNIQUE btree (uuid)
