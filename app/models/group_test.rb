class GroupTest < ApplicationRecord
  belongs_to :test
  belongs_to :group

  def self.create_group_tests(group_ids, test_id)
  	print "\n Inside the create_group_tests function \n"
		group_ids.each do |g_id|
			GroupTest.create(group_id: g_id, test_id: test_id)
			print "\n Group test created \n"
		end 
  end 
=begin We can implement functions showing all groups with that particualr test and without it: 
  def self.teachers_groups_test(teacher_id, test)
  	print "\n inside teachers_groups_with_test, teacher id is #{teacher_id}, test.id is #{test.id} \n"

    all_teachers_groups = Group.where(teacher_id: teacher_id)
   	print "\n all_teachers_groups are: #{all_teachers_groups.inspect} \n"

    groups_with_tests = []
    grpups_without_test = []

    all_teachers_groups.each do |tg| 
    	 tg.tests.blank? ?  groups_without_test.push(tg) : groups_with_test.push(tg)
    end 
    #teachers_groups_with_test = all_teachers_groups - test.groups 
    [groups_with_test, groups_without_test]
  end 
=end 

  def self.reassign_groups_test(teacher_id, test_id, new_assigned_groups_ids)
  	@test = Test.find(test_id)
  	print "\n inside teachers_groups_with_test, teacher id is #{teacher_id}, test.id is #{test_id} \n"
  	# We have to delete all previuos entires from group_test related to this test all al groyp that have it
    all_teachers_groups = Group.where(teacher_id: teacher_id)
    
  	print "\n\n Is the group test array for this test false or not: #{GroupTest.where(test_id: test_id).blank?} \n \n" 
  	GroupTest.where(test_id: test_id).destroy_all 

  	# ... the same as above could be done in a long way by operating directly on the GroupTest with every group.id
=begin
  	unless all_teachers_groups.blank? 
	  	all_teachers_groups.each do |group| 
	  		print "\n inside all teacher_group loop ou group_id is #{group.id} \n"
	  		#retried the group_test with g_id and tes_id 
	  		#destroy that group_test relation 
	  		#repeat both above steps for every g_id 

	  		group_test = GroupTest.where(group_id: group.id, test_id: test_id).first
	  		print "\n group_test is #{group_test.inspect} \n"
	  	  GroupTest.destroy(group_test.id) if !group_test.blank?
	  	  print "\n destroyoed groyp test with group_id: #{group.id} and test_id: #{test_id} \n"
	  	end 
	  end	
=end	  
  	print "now after destorying the previous relationships the reassignment needs to happen"


    unless new_assigned_groups_ids.blank?
	 		selected_groups = Group.find(new_assigned_groups_ids)
			@test.update(groups: selected_groups) unless new_assigned_groups_ids.blank?
		end 	

		#the code below could be refactored like so
=begin
  	unless new_assigned_groups_ids.blank?
			new_assigned_groups_ids.each do |g_id| 
				GroupTest.create(group_id: g_id, test_id: test_id)
				print "\n created group_test with id of #{g_id} and test_id of #{test_id}\n\n"
			end
		end 	
=end		

	 # print "GroupTests table seems not to have any record with test_id: #{test_id}. "
	end   
end
