class DataModel {
  final String txn_date;
  final String province;
  final int new_case;
  final int total_case;
  final int new_case_excludeabroad;
  final int total_case_excludeabroad;
  final int new_death;
  final int total_death;
  final String update_date;

  DataModel(
      {
      this.txn_date,
      this.province,
      this.new_case,
      this.total_case,
      this.new_case_excludeabroad,
      this.total_case_excludeabroad,
      this.new_death,
      this.total_death,
      this.update_date});
  factory DataModel.fromJson(Map<String,dynamic> json) {
    return DataModel(txn_date: json["date"],
    province: json["province"],
    new_case: json["new_case"],
    total_case: json["total_case"],
    new_case_excludeabroad: json["new_case_excludeabroad"],
    total_case_excludeabroad: json["total_case_excludeabroad"],
    new_death: json["new_death"],
    update_date: json["update_date"],);
  }
}
