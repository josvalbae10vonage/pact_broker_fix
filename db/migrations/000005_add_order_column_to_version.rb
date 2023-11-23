Sequel.migration do
  change do
    rename_column(:versions, :oorder , :order)
  end
end

