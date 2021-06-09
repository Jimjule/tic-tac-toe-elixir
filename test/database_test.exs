defmodule DatabaseTest do
  use ExUnit.Case
  Logger.configure(level: :notice)

  test "can query the empty database" do
    assert length(Database.get_all_records()) == 0
  end

  test "can search the database by id" do
    assert Database.get_record_by_id("1") == nil
  end

  test "can search the database by name" do
    assert length(Database.get_records_by_player_name("A")) == 0
  end
end
