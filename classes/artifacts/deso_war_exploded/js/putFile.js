function putFile(file,folder,folder2) {
  const albumBucketName = 'deso-file'; 
  const region = 'ap-northeast-2';
  const accessKeyId = 'AKIASY7H32WRHYU22GVH'; 
  const secretAccessKey = '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'; 
  const key = (folder2 != null && folder2 != "")? folder+"/"+folder2+"/"+file.name : folder+"/"+file.name;

  AWS.config.update({
    region,
    accessKeyId, 
    secretAccessKey
  }); 
  
  const upload = new AWS.S3.ManagedUpload({
    params: {
      Bucket: albumBucketName,
      Key: key,
	  ACL: 'public-read',
      Body: file
    }
  });
  
  const promise = upload.promise();
  promise.then(
    function(data) {
	  return console.log("업로드 성공");
    },
    function(err) {
	  return console.log("업로드 실패");
    }
  );

  
};