terraform{
    backend "s3"
    {
        bucket = "467.devops.candidate.exam"
        Region: "ap-south-1"
        Key: "<Your First Name>.<You Last Name>"
    }
}