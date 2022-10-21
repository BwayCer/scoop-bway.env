
# https://stackoverflow.com/questions/885349/how-do-i-write-a-powershell-script-that-accepts-pipeline-input
# https://4sysops.com/archives/understanding-powershell-begin-process-and-end-blocks/
function handlePipeInput {
  Param (
    [Parameter(
      Position=0,
      Mandatory=$true,
      ValueFromPipeline=$true,
      ValueFromPipelineByPropertyName=$true
      )]
    [Alias('FullName')]
    [String[]]
    $FilePath
  )

  begin {
    'c: pipe: -- begin ---'
  }

  process {
    foreach($path in $FilePath) {
      "  {0}" -f $path
    }
  }

  end {
    'c: pipe: -- end ---'
  }
}


"c: PSScriptRoot:  {0}" -f $PSScriptRoot
"c: PSCommandPath: {0}" -f $PSCommandPath
"c: MyInvocation:  {0}" -f $MyInvocation.MyCommand.Path
"c: isHasInput: {0}" -f $MyInvocation.expectingInput
"c: Count: {0} args: {1}" -f $args.Count, ($args -join ", ")
"c: tmp: {0}" -f $tmp

if ($MyInvocation.expectingInput) {
  $input | handlePipeInput 
}

