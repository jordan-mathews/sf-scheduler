@isTest
public class ResourceAvailabilityServiceTest {
  @isTest
  static void getAppCandidatesTest() {
    String expectedResponse =
      '[' +
      '  {' +
      '    \"startTime\": \"2021-03-18T16:00:00.000+0000\",' +
      '    \"endTime\": \"2021-03-18T17:00:00.000+0000\",' +
      '    \"resources\": [' +
      '      \"0HnRM0000000Fxv0AE\"' +
      '    ],' +
      '    \"territoryId\": \"0HhRM0000000G8W0AU\"' +
      '  },' +
      '  {' +
      '    \"startTime\": \"2021-03-18T19:00:00.000+0000\",' +
      '    \"endTime\": \"2021-03-18T20:00:00.000+0000\",' +
      '    \"resources\": [' +
      '      \"0HnRM0000000Fxv0AE\"' +
      '    ],' +
      '    \"territoryId\": \"0HhRM0000000G8W0AU\"' +
      '  }' +
      ']';
    lxscheduler.SchedulerResources.setAppointmentCandidatesMock(expectedResponse);

    Test.startTest();
    ResourceAvailabilityService roomService = new ResourceAvailabilityService();
    List<ResourceAvailabilityService.AppointmentCandidate> candidateList = roomService.getAppointmentCandidates();
    System.assertEquals(2, candidateList.size(), 'Should return only 2 candidates!');
    Test.stopTest();
  }

  @isTest
  static void getAvailableTimeSlotsTest() {
    String expectedResponse =
      '[' +
      '  {' +
      '    \"startTime\": \"2021-03-18T16:00:00.000+0000\",' +
      '    \"endTime\": \"2021-03-18T17:00:00.000+0000\",' +
      '    \"territoryId\": \"0HhRM0000000G8W0AU\",' +
      '    \"remainingAppointments\": 1' +
      '  },' +
      '  {' +
      '    \"startTime\": \"2021-03-18T19:00:00.000+0000\",' +
      '    \"endTime\": \"2021-03-18T20:00:00.000+0000\",' +
      '    \"territoryId\": \"0HhRM0000000G8W0AU\",' +
      '    \"remainingAppointments\": 1' +
      '  }' +
      ']';
    lxscheduler.SchedulerResources.setAppointmentSlotsMock(expectedResponse);

    Test.startTest();
    ResourceAvailabilityService roomService = new ResourceAvailabilityService();
    List<ResourceAvailabilityService.TimeSlot> timeSlotList = roomService.getAvailableTimeSlots();
    System.assertEquals(2, timeSlotList.size(), 'Should return 2 time slots');
    Test.stopTest();
  }

  @isTest
  static void constructorTest() {
    String startTime = '2021-03-18 08:30:00';
    String endTime = '2021-03-18 16:00:00';
    String workTypeId = '0HhRM0000000G8W0AU';
    String territoryId = '0HhRM0000000G8W0AU';
    ResourceAvailabilityService roomService = new ResourceAvailabilityService(
      startTime,
      endTime,
      workTypeId,
      territoryId
    );
  }

  @isTest
  static void constructorResourceTest() {
    String startTime = '2021-03-18 08:30:00';
    String endTime = '2021-03-18 16:00:00';
    String workTypeId = '0HhRM0000000G8W0AU';
    String territoryId = '0HhRM0000000G8W0AU';
    List<String> resources = new List<String>{ '0HhRM0000000G8W0AU' };
    ResourceAvailabilityService roomService = new ResourceAvailabilityService(
      startTime,
      endTime,
      workTypeId,
      resources,
      territoryId
    );
  }
}
