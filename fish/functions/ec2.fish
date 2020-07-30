function ec2
  switch $argv[1]
    case oopy-controller
      command ssh -i ~/.ssh/oopy.pem ec2-user@ec2-3-34-47-126.ap-northeast-2.compute.amazonaws.com
    case oopy-hasura
      command ssh -i ~/.ssh/oopy.pem ec2-user@ec2-13-125-216-80.ap-northeast-2.compute.amazonaws.com
    case yelty-hasura
      command ssh -i ~/.ssh/yelty.pem ec2-user@ec2-54-146-84-74.compute-1.amazonaws.com
  end
end
