public with sharing class ResourceAvailabilityService {
  private static final String DATE_TIME_FORMAT = 'yyyy-MM-dd\'T\'HH:mm:ssZ';
  private String endTime { get; set; }
  private String startTime { get; set; }
  private String workTypeId { get; set; }
  public String territoryId { get; set; }
  private List<String> resources { get; set; }

  public ResourceAvailabilityService(
    String startTime,
    String endTime,
    String workTypeId,
    List<String> resources,
    String territoryId
  ) {
    this.startTime = DateTime.valueOf(startTime).format(DATE_TIME_FORMAT);
    this.endTime = DateTime.valueOf(endTime).format(DATE_TIME_FORMAT);
    this.workTypeId = workTypeId;
    this.territoryId = territoryId;
    this.resources = resources;
  }

  public ResourceAvailabilityService(String startTime, String endTime, String workTypeId, String territoryId) {
    this.startTime = DateTime.valueOf(startTime).format(DATE_TIME_FORMAT);
    this.endTime = DateTime.valueOf(endTime).format(DATE_TIME_FORMAT);
    this.workTypeId = workTypeId;
    this.territoryId = territoryId;
    this.resources = resources;
  }

  public ResourceAvailabilityService() {
  
  }

  public List<TimeSlot> getAvailableTimeSlots() {
    lxscheduler.WorkType workType = new lxscheduler.WorkTypeBuilder().setId(this.workTypeId).build();

    lxscheduler.GetAppointmentSlotsInput input = new lxscheduler.GetAppointmentSlotsInputBuilder()
      .setWorkType(workType)
      .setTerritoryIds(new List<String>{ this.territoryId })
      .setStartTime(this.startTime)
      .setEndTime(this.endTime)
      .setRequiredResourceIds(this.resources)
      .build();

    String response = lxscheduler.SchedulerResources.getAppointmentSlots(input);
    List<TimeSlot> timeSlotList = AppointmentCandidate.parseTimeSlots(
      lxscheduler.SchedulerResources.getAppointmentSlots(input)
    );

    return timeSlotList;
  }

  public List<AppointmentCandidate> getAppointmentCandidates() {
    lxscheduler.WorkType workType = new lxscheduler.WorkTypeBuilder().setId(this.workTypeId).build();

    lxscheduler.GetAppointmentCandidatesInput input = new lxscheduler.GetAppointmentCandidatesInputBuilder()
      .setWorkType(workType)
      .setTerritoryIds(new List<String>{ this.territoryId })
      .setStartTime(this.startTime)
      .setEndTime(this.endTime)
      .build();

    List<AppointmentCandidate> candidateList = AppointmentCandidate.parseAppointmentCandidates(
      lxscheduler.SchedulerResources.getAppointmentCandidates(input)
    );

    return candidateList;
  }

  public class AppointmentCandidate {
    @AuraEnabled
    public String endTime;
    @AuraEnabled
    public String startTime;
    @AuraEnabled
    public String workTypeId;
    @AuraEnabled
    public String territoryId;
    @AuraEnabled
    public List<String> resources;
  }

  public class TimeSlot {
    @AuraEnabled
    public String endTime;
    @AuraEnabled
    public Integer remainingAppointments;
    @AuraEnabled
    public String startTime;
    @AuraEnabled
    public String territoryId;
  }

  private static List<AppointmentCandidate> parseAppointmentCandidates(String json) {
    return (List<AppointmentCandidate>) System.JSON.deserialize(json, List<AppointmentCandidate>.class);
  }

  private static List<TimeSlot> parseTimeSlots(String json) {
    return (List<TimeSlot>) System.JSON.deserialize(json, List<TimeSlot>.class);
  }
}
