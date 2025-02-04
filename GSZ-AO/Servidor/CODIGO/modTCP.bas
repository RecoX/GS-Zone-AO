Attribute VB_Name = "modTCP"
'Argentum Online 0.12.2
'Copyright (C) 2002 M�rquez Pablo Ignacio
'
'This program is free software; you can redistribute it and/or modify
'it under the terms of the Affero General Public License;
'either version 1 of the License, or any later version.
'
'This program is distributed in the hope that it will be useful,
'but WITHOUT ANY WARRANTY; without even the implied warranty of
'MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
'Affero General Public License for more details.
'
'You should have received a copy of the Affero General Public License
'along with this program; if not, you can find it at http://www.affero.org/oagpl.html
'
'Argentum Online is based on Baronsoft's VB6 Online RPG
'You can contact the original creator of ORE at aaron@baronsoft.com
'for more information about ORE please visit http://www.baronsoft.com/
'
'
'You can contact me at:
'morgolock@speedy.com.ar
'www.geocities.com/gmorgolock
'Calle 3 n�mero 983 piso 7 dto A
'La Plata - Pcia, Buenos Aires - Republica Argentina
'C�digo Postal 1900
'Pablo Ignacio M�rquez

Option Explicit

#If UsarQueSocket = 0 Then
' General constants used with most of the controls
Public Const INVALID_HANDLE As Integer = -1
Public Const CONTROL_ERRIGNORE As Integer = 0
Public Const CONTROL_ERRDISPLAY As Integer = 1


' SocietWrench Control Actions
Public Const SOCKET_OPEN As Integer = 1
Public Const SOCKET_CONNECT As Integer = 2
Public Const SOCKET_LISTEN As Integer = 3
Public Const SOCKET_ACCEPT As Integer = 4
Public Const SOCKET_CANCEL As Integer = 5
Public Const SOCKET_FLUSH As Integer = 6
Public Const SOCKET_CLOSE As Integer = 7
Public Const SOCKET_DISCONNECT As Integer = 7
Public Const SOCKET_ABORT As Integer = 8

' SocketWrench Control States
Public Const SOCKET_NONE As Integer = 0
Public Const SOCKET_IDLE As Integer = 1
Public Const SOCKET_LISTENING As Integer = 2
Public Const SOCKET_CONNECTING As Integer = 3
Public Const SOCKET_ACCEPTING As Integer = 4
Public Const SOCKET_RECEIVING As Integer = 5
Public Const SOCKET_SENDING As Integer = 6
Public Const SOCKET_CLOSING As Integer = 7

' Societ Address Families
Public Const AF_UNSPEC As Integer = 0
Public Const AF_UNIX As Integer = 1
Public Const AF_INET As Integer = 2

' Societ Types
Public Const SOCK_STREAM As Integer = 1
Public Const SOCK_DGRAM As Integer = 2
Public Const SOCK_RAW As Integer = 3
Public Const SOCK_RDM As Integer = 4
Public Const SOCK_SEQPACKET As Integer = 5

' Protocol Types
Public Const IPPROTO_IP As Integer = 0
Public Const IPPROTO_ICMP As Integer = 1
Public Const IPPROTO_GGP As Integer = 2
Public Const IPPROTO_TCP As Integer = 6
Public Const IPPROTO_PUP As Integer = 12
Public Const IPPROTO_UDP As Integer = 17
Public Const IPPROTO_IDP As Integer = 22
Public Const IPPROTO_ND As Integer = 77
Public Const IPPROTO_RAW As Integer = 255
Public Const IPPROTO_MAX As Integer = 256


' Network Addpesses
Public Const INADDR_ANY As String = "0.0.0.0"
Public Const INADDR_LOOPBACK As String = "127.0.0.1"
Public Const INADDR_NONE As String = "255.055.255.255"

' Shutdown Values
Public Const SOCKET_READ As Integer = 0
Public Const SOCKET_WRITE As Integer = 1
Public Const SOCKET_READWRITE As Integer = 2

' SocketWrench Error Pesponse
Public Const SOCKET_ERRIGNORE As Integer = 0
Public Const SOCKET_ERRDISPLAY As Integer = 1

' SocketWrench Error Codes
Public Const WSABASEERR As Integer = 24000
Public Const WSAEINTR As Integer = 24004
Public Const WSAEBADF As Integer = 24009
Public Const WSAEACCES As Integer = 24013
Public Const WSAEFAULT As Integer = 24014
Public Const WSAEINVAL As Integer = 24022
Public Const WSAEMFILE As Integer = 24024
Public Const WSAEWOULDBLOCK As Integer = 24035
Public Const WSAEINPROGRESS As Integer = 24036
Public Const WSAEALREADY As Integer = 24037
Public Const WSAENOTSOCK As Integer = 24038
Public Const WSAEDESTADDRREQ As Integer = 24039
Public Const WSAEMSGSIZE As Integer = 24040
Public Const WSAEPROTOTYPE As Integer = 24041
Public Const WSAENOPROTOOPT As Integer = 24042
Public Const WSAEPROTONOSUPPORT As Integer = 24043
Public Const WSAESOCKTNOSUPPORT As Integer = 24044
Public Const WSAEOPNOTSUPP As Integer = 24045
Public Const WSAEPFNOSUPPORT As Integer = 24046
Public Const WSAEAFNOSUPPORT As Integer = 24047
Public Const WSAEADDRINUSE As Integer = 24048
Public Const WSAEADDRNOTAVAIL As Integer = 24049
Public Const WSAENETDOWN As Integer = 24050
Public Const WSAENETUNREACH As Integer = 24051
Public Const WSAENETRESET As Integer = 24052
Public Const WSAECONNABORTED As Integer = 24053
Public Const WSAECONNRESET As Integer = 24054
Public Const WSAENOBUFS As Integer = 24055
Public Const WSAEISCONN As Integer = 24056
Public Const WSAENOTCONN As Integer = 24057
Public Const WSAESHUTDOWN As Integer = 24058
Public Const WSAETOOMANYREFS As Integer = 24059
Public Const WSAETIMEDOUT As Integer = 24060
Public Const WSAECONNREFUSED As Integer = 24061
Public Const WSAELOOP As Integer = 24062
Public Const WSAENAMETOOLONG As Integer = 24063
Public Const WSAEHOSTDOWN As Integer = 24064
Public Const WSAEHOSTUNREACH As Integer = 24065
Public Const WSAENOTEMPTY As Integer = 24066
Public Const WSAEPROCLIM As Integer = 24067
Public Const WSAEUSERS As Integer = 24068
Public Const WSAEDQUOT As Integer = 24069
Public Const WSAESTALE As Integer = 24070
Public Const WSAEREMOTE As Integer = 24071
Public Const WSASYSNOTREADY As Integer = 24091
Public Const WSAVERNOTSUPPORTED As Integer = 24092
Public Const WSANOTINITIALISED As Integer = 24093
Public Const WSAHOST_NOT_FOUND As Integer = 25001
Public Const WSATRY_AGAIN As Integer = 25002
Public Const WSANO_RECOVERY As Integer = 25003
Public Const WSANO_DATA As Integer = 25004
Public Const WSANO_ADDRESS As Integer = 2500
#End If

Sub DarCuerpo(ByVal UserIndex As Integer)
'*************************************************
'Author: Nacho (Integer)
'Last modified: 14/03/2007
'Elije una cabeza para el usuario y le da un body
'*************************************************
Dim NewBody As Integer
Dim UserRaza As Byte
Dim UserGenero As Byte

UserGenero = UserList(UserIndex).Genero
UserRaza = UserList(UserIndex).raza

Select Case UserGenero
   Case eGenero.Hombre
        Select Case UserRaza
            Case eRaza.Humano
                NewBody = 1
            Case eRaza.Elfo
                NewBody = 2
            Case eRaza.Drow
                NewBody = 3
            Case eRaza.Enano
                NewBody = 300
            Case eRaza.Gnomo
                NewBody = 300
        End Select
   Case eGenero.Mujer
        Select Case UserRaza
            Case eRaza.Humano
                NewBody = 1
            Case eRaza.Elfo
                NewBody = 2
            Case eRaza.Drow
                NewBody = 3
            Case eRaza.Gnomo
                NewBody = 300
            Case eRaza.Enano
                NewBody = 300
        End Select
End Select

UserList(UserIndex).Char.Body = NewBody
End Sub

Private Function ValidarCabeza(ByVal UserRaza As Byte, ByVal UserGenero As Byte, ByVal Head As Integer) As Boolean

Select Case UserGenero
    Case eGenero.Hombre
        Select Case UserRaza
            Case eRaza.Humano
                ValidarCabeza = (Head >= HUMANO_H_PRIMER_CABEZA And Head <= HUMANO_H_ULTIMA_CABEZA)
            Case eRaza.Elfo
                ValidarCabeza = (Head >= ELFO_H_PRIMER_CABEZA And Head <= ELFO_H_ULTIMA_CABEZA)
            Case eRaza.Drow
                ValidarCabeza = (Head >= DROW_H_PRIMER_CABEZA And Head <= DROW_H_ULTIMA_CABEZA)
            Case eRaza.Enano
                ValidarCabeza = (Head >= ENANO_H_PRIMER_CABEZA And Head <= ENANO_H_ULTIMA_CABEZA)
            Case eRaza.Gnomo
                ValidarCabeza = (Head >= GNOMO_H_PRIMER_CABEZA And Head <= GNOMO_H_ULTIMA_CABEZA)
        End Select
    
    Case eGenero.Mujer
        Select Case UserRaza
            Case eRaza.Humano
                ValidarCabeza = (Head >= HUMANO_M_PRIMER_CABEZA And Head <= HUMANO_M_ULTIMA_CABEZA)
            Case eRaza.Elfo
                ValidarCabeza = (Head >= ELFO_M_PRIMER_CABEZA And Head <= ELFO_M_ULTIMA_CABEZA)
            Case eRaza.Drow
                ValidarCabeza = (Head >= DROW_M_PRIMER_CABEZA And Head <= DROW_M_ULTIMA_CABEZA)
            Case eRaza.Enano
                ValidarCabeza = (Head >= ENANO_M_PRIMER_CABEZA And Head <= ENANO_M_ULTIMA_CABEZA)
            Case eRaza.Gnomo
                ValidarCabeza = (Head >= GNOMO_M_PRIMER_CABEZA And Head <= GNOMO_M_ULTIMA_CABEZA)
        End Select
End Select
        
End Function

Function AsciiValidos(ByVal cad As String) As Boolean
'***************************************************
'Author: Unknownn
'Last Modification: -
'
'***************************************************

Dim car As Byte
Dim i As Integer

cad = LCase$(cad)

For i = 1 To Len(cad)
    car = Asc(mid$(cad, i, 1))
    
    If (car < 97 Or car > 122) And (car <> 255) And (car <> 32) Then
        AsciiValidos = False
        Exit Function
    End If
    
Next i

AsciiValidos = True

End Function

Function AsciiValidosDesc(ByVal cad As String) As Boolean
'***************************************************
'Author: ^[GS]^
'Last Modification: 08/07/2012 - ^[GS]^
'
'***************************************************
Dim car As Byte
Dim i As Integer
cad = LCase$(cad)
For i = 1 To Len(cad)
    car = Asc(mid$(cad, i, 1))
    If car = 126 Or car = 60 Or car = 61 Or car = 62 Or car = 91 Or car = 93 Then
        ' prohibimos ~<=>[] porque se usan para clan, grupos, rangos, etc...
        AsciiValidosDesc = False
        Exit Function
    End If
    If ((car < 32 And car > 126) Or (car < 160 And car > 175) And (car <> 255) And (car <> 32)) Then
        ' muchos caracateres incluidos los ascentos ;)
        MsgBox car & " " & Chr(car)
        AsciiValidosDesc = False
        Exit Function
    End If
Next i
AsciiValidosDesc = True
End Function


Function Numeric(ByVal cad As String) As Boolean
'***************************************************
'Author: Unknownn
'Last Modification: -
'
'***************************************************

Dim car As Byte
Dim i As Integer

cad = LCase$(cad)

For i = 1 To Len(cad)
    car = Asc(mid$(cad, i, 1))
    
    If (car < 48 Or car > 57) Then
        Numeric = False
        Exit Function
    End If
    
Next i

Numeric = True

End Function


Function NombrePermitido(ByVal Nombre As String) As Boolean
'***************************************************
'Author: Unknownn
'Last Modification: -
'
'***************************************************

Dim i As Integer

For i = 1 To UBound(ForbidenNames)
    If InStr(Nombre, ForbidenNames(i)) And ForbidenNames(i) <> vbNullString Then
            NombrePermitido = False
            Exit Function
    End If
Next i

NombrePermitido = True

End Function

Function ValidateSkills(ByVal UserIndex As Integer) As Boolean
'***************************************************
'Author: Unknownn
'Last Modification: -
'
'***************************************************

Dim LoopC As Integer

For LoopC = 1 To NUMSKILLS
    If UserList(UserIndex).Stats.UserSkills(LoopC) < 0 Then
        Exit Function
        If UserList(UserIndex).Stats.UserSkills(LoopC) > 100 Then UserList(UserIndex).Stats.UserSkills(LoopC) = 100
    End If
Next LoopC

ValidateSkills = True
    
End Function

Sub ConnectNewUser(ByVal UserIndex As Integer, ByRef Name As String, ByRef Password As String, ByVal UserRaza As eRaza, ByVal UserSexo As eGenero, ByVal UserClase As eClass, ByRef UserEmail As String, ByVal Hogar As Byte, ByVal Head As Integer, ByVal SerialHD As String)
'*************************************************
'Author: Unknownn
'Last modified: 18/03/2013 - ^[GS]^
'*************************************************
Dim i As Long

With UserList(UserIndex)

    If Not AsciiValidos(Name) Or LenB(Name) = 0 Or NombrePermitido(Name) = False Then
        Call WriteErrorMsg(UserIndex, "Nombre inv�lido.")
        Exit Sub
    End If
    
    If UserList(UserIndex).flags.UserLogged Then
        Call LogCheating("El usuario " & UserList(UserIndex).Name & " ha intentado crear a " & Name & " desde la IP " & UserList(UserIndex).ip)
        
        'Kick player ( and leave character inside :D )!
        Call CloseSocketSL(UserIndex)
        Call Cerrar_Usuario(UserIndex)
        
        Exit Sub
    End If
       
    '�Existe el personaje? (Fedudok)
    #If Mysql = 0 Then
    
    If FileExist(CharPath & UCase$(Name) & ".chr", vbNormal) = True Then
        Call WriteErrorMsg(UserIndex, "Ya existe el personaje.")
        Exit Sub
    End If
    
    #Else
    
    If ExistePersonaje(Name) Then
        Call WriteErrorMsg(UserIndex, "Ya existe el personaje.")
        Exit Sub
    End If
    
    #End If
    '�Existe el personaje? (Fedudok)
    
    
    'Tir� los dados antes de llegar ac�??
    If .Stats.UserAtributos(eAtributos.Fuerza) = 0 Then
        Call WriteErrorMsg(UserIndex, "Debe tirar los dados antes de poder crear un personaje.")
        Exit Sub
    End If
    
    If Not ValidarCabeza(UserRaza, UserSexo, Head) Then
        Call LogCheating("El usuario " & Name & " ha seleccionado la cabeza " & Head & " desde la IP " & .ip)
        
        Call WriteErrorMsg(UserIndex, "Cabeza inv�lida, elija una cabeza seleccionable.")
        Exit Sub
    End If
    
    .flags.Muerto = 0
    .flags.Escondido = 0
    .flags.FormYesNoType = 0 ' GSZAO
    .flags.FormYesNoA = 0 ' GSZAO
    .flags.FormYesNoDE = 0 ' GSZAO
    .flags.SerialHD = SerialHD ' GSZAO
    
    .Reputacion.AsesinoRep = 0
    .Reputacion.BandidoRep = 0
    .Reputacion.BurguesRep = 0
    .Reputacion.LadronesRep = 0
    .Reputacion.NobleRep = 1000
    .Reputacion.PlebeRep = 30
    
    .Reputacion.Promedio = 30 / 6
    
    
    .Name = Name
    .clase = UserClase
    .raza = UserRaza
    .Genero = UserSexo
    .Hogar = Hogar
    
    '[Pablo (Toxic Waste) 9/01/08]
    .Stats.UserAtributos(eAtributos.Fuerza) = .Stats.UserAtributos(eAtributos.Fuerza) + ModRaza(UserRaza).Fuerza
    .Stats.UserAtributos(eAtributos.Agilidad) = .Stats.UserAtributos(eAtributos.Agilidad) + ModRaza(UserRaza).Agilidad
    .Stats.UserAtributos(eAtributos.Inteligencia) = .Stats.UserAtributos(eAtributos.Inteligencia) + ModRaza(UserRaza).Inteligencia
    .Stats.UserAtributos(eAtributos.Carisma) = .Stats.UserAtributos(eAtributos.Carisma) + ModRaza(UserRaza).Carisma
    .Stats.UserAtributos(eAtributos.Constitucion) = .Stats.UserAtributos(eAtributos.Constitucion) + ModRaza(UserRaza).Constitucion
    '[/Pablo (Toxic Waste)]
    
    For i = 1 To NUMSKILLS
        .Stats.UserSkills(i) = 0
        Call CheckEluSkill(UserIndex, i, True)
    Next i
    
    .Stats.SkillPts = 10
    
    .Char.heading = eHeading.SOUTH
    
    Call DarCuerpo(UserIndex)
    .Char.Head = Head
    
    .OrigChar = .Char
    
    Dim MiInt As Long
    MiInt = RandomNumber(1, .Stats.UserAtributos(eAtributos.Constitucion) \ 3)
    
    .Stats.MaxHp = 15 + MiInt
    .Stats.MinHp = 15 + MiInt
    
    MiInt = RandomNumber(1, .Stats.UserAtributos(eAtributos.Agilidad) \ 6)
    If MiInt = 1 Then MiInt = 2
    
    .Stats.MaxSta = 20 * MiInt
    .Stats.MinSta = 20 * MiInt
    
    
    .Stats.MaxAGU = 100
    .Stats.MinAGU = 100
    
    .Stats.MaxHam = 100
    .Stats.MinHam = 100
    
    
    '<-----------------MANA----------------------->
    If UserClase = eClass.Mage Then 'Cambio en mana inicial (ToxicWaste)
        MiInt = .Stats.UserAtributos(eAtributos.Inteligencia) * 3
        .Stats.MaxMAN = MiInt
        .Stats.MinMAN = MiInt
    ElseIf UserClase = eClass.Cleric Or UserClase = eClass.Druid Or UserClase = eClass.Bard Or UserClase = eClass.Assasin Then
            .Stats.MaxMAN = 50
            .Stats.MinMAN = 50
    ElseIf UserClase = eClass.Bandit Then 'Mana Inicial del Bandido (ToxicWaste)
            .Stats.MaxMAN = 50
            .Stats.MinMAN = 50
    Else
        .Stats.MaxMAN = 0
        .Stats.MinMAN = 0
    End If
    
    If UserClase = eClass.Mage Or UserClase = eClass.Cleric Or UserClase = eClass.Druid Or UserClase = eClass.Bard Or UserClase = eClass.Assasin Then
            .Stats.UserHechizos(1) = 2
        
            If UserClase = eClass.Druid Then .Stats.UserHechizos(2) = 46
    End If
    
    .Stats.MaxHIT = 2
    .Stats.MinHIT = 1
    
    .Stats.GLD = 0
    
    .Stats.Exp = 0
    .Stats.ELU = 300
    .Stats.ELV = 1
    
    '???????????????? INVENTARIO ��������������������
    Dim Slot As Byte
    Dim IsPaladin As Boolean
    
    IsPaladin = UserClase = eClass.Paladin
    
    'Pociones Rojas (Newbie)
    Slot = 1
    .Invent.Object(Slot).ObjIndex = 857
    .Invent.Object(Slot).Amount = 200
    
    'Pociones azules (Newbie)
    If .Stats.MaxMAN > 0 Or IsPaladin Then
        Slot = Slot + 1
        .Invent.Object(Slot).ObjIndex = 856
        .Invent.Object(Slot).Amount = 200
    
    Else
        'Pociones amarillas (Newbie)
        Slot = Slot + 1
        .Invent.Object(Slot).ObjIndex = 855
        .Invent.Object(Slot).Amount = 100
    
        'Pociones verdes (Newbie)
        Slot = Slot + 1
        .Invent.Object(Slot).ObjIndex = 858
        .Invent.Object(Slot).Amount = 50
    
    End If
    
    ' Ropa (Newbie)
    Slot = Slot + 1
    Select Case UserRaza
        Case eRaza.Humano
            .Invent.Object(Slot).ObjIndex = 463
        Case eRaza.Elfo
            .Invent.Object(Slot).ObjIndex = 464
        Case eRaza.Drow
            .Invent.Object(Slot).ObjIndex = 465
        Case eRaza.Enano
            .Invent.Object(Slot).ObjIndex = 466
        Case eRaza.Gnomo
            .Invent.Object(Slot).ObjIndex = 466
    End Select
    
    ' Equipo ropa
    .Invent.Object(Slot).Amount = 1
    .Invent.Object(Slot).Equipped = 1
    
    .Invent.ArmourEqpSlot = Slot
    .Invent.ArmourEqpObjIndex = .Invent.Object(Slot).ObjIndex

    'Arma (Newbie)
    Slot = Slot + 1
    Select Case UserClase
        Case eClass.Hunter
            ' Arco (Newbie)
            .Invent.Object(Slot).ObjIndex = 859
        Case eClass.Worker
            ' Herramienta (Newbie)
            .Invent.Object(Slot).ObjIndex = RandomNumber(561, 565)
        Case Else
            ' Daga (Newbie)
            .Invent.Object(Slot).ObjIndex = 460
    End Select
    
    ' Equipo arma
    .Invent.Object(Slot).Amount = 1
    .Invent.Object(Slot).Equipped = 1
    
    .Invent.WeaponEqpObjIndex = .Invent.Object(Slot).ObjIndex
    .Invent.WeaponEqpSlot = Slot
    
    .Char.WeaponAnim = GetWeaponAnim(UserIndex, .Invent.WeaponEqpObjIndex)

    ' Municiones (Newbie)
    If UserClase = eClass.Hunter Then
        Slot = Slot + 1
        .Invent.Object(Slot).ObjIndex = 860
        .Invent.Object(Slot).Amount = 150
        
        ' Equipo flechas
        .Invent.Object(Slot).Equipped = 1
        .Invent.MunicionEqpSlot = Slot
        .Invent.MunicionEqpObjIndex = 860
    End If

    ' Manzanas (Newbie)
    Slot = Slot + 1
    .Invent.Object(Slot).ObjIndex = 467
    .Invent.Object(Slot).Amount = 100
    
    ' Jugos (Nwbie)
    Slot = Slot + 1
    .Invent.Object(Slot).ObjIndex = 468
    .Invent.Object(Slot).Amount = 100
    
    ' Sin casco y escudo
    .Char.ShieldAnim = NingunEscudo
    .Char.CascoAnim = NingunCasco
    
    ' Total Items
    .Invent.NroItems = Slot

End With

'Valores Default de facciones al Activar nuevo usuario
Call ResetFacciones(UserIndex)

' Guardado de personaje(Fedudok)
#If Mysql = 0 Then
    Call WriteVar(CharPath & UCase$(Name) & ".chr", "INIT", "Password", Password) 'grabamos el password aqui afuera, para no mantenerlo cargado en memoria
    Call SaveUser(UserIndex, CharPath & UCase$(Name) & ".chr")
#Else
    Call SaveUserSQL(UserIndex, True)
#End If
' Guardado de personaje(Fedudok)

'Open User
Call ConnectUser(UserIndex, Name, Password, SerialHD)
  
End Sub

#If UsarQueSocket = 1 Or UsarQueSocket = 2 Then

Sub CloseSocket(ByVal UserIndex As Integer)
'***************************************************
'Author: Unknownn
'Last Modification: 27/07/2011 - ^[GS]^
'***************************************************

On Error GoTo ErrHandler
    
    With UserList(UserIndex)
        
        Call modSecurityIp.IpRestarConexion(GetLongIp(.ip))
        
        If .ConnID <> -1 Then
            Call CloseSocketSL(UserIndex)
        End If
        
        CloseSocketAtTorneo UserIndex
        
        'Es el mismo user al que est� revisando el centinela??
        'IMPORTANTE!!! hacerlo antes de resetear as� todav�a sabemos el nombre del user
        ' y lo podemos loguear
        Dim CentinelaIndex As Byte
        CentinelaIndex = .flags.CentinelaIndex
        
        If CentinelaIndex <> 0 Then
            Call modCentinela.CentinelaUserLogout(CentinelaIndex)
        End If
        
        'mato los comercios seguros
        If .ComUsu.DestUsu > 0 Then
            If UserList(.ComUsu.DestUsu).flags.UserLogged Then
                If UserList(.ComUsu.DestUsu).ComUsu.DestUsu = UserIndex Then
                    Call WriteMensajes(.ComUsu.DestUsu, eMensajes.Mensaje001) '"Comercio cancelado por el otro usuario."
                    Call FinComerciarUsu(.ComUsu.DestUsu)
                    Call FlushBuffer(.ComUsu.DestUsu)
                End If
            End If
        End If
        
        'Empty buffer for reuse
        Call .incomingData.ReadASCIIStringFixed(.incomingData.length)
        
        If .flags.UserLogged Then
            If NumUsers > 0 Then NumUsers = NumUsers - 1
            'Actualizo el frmMain. / maTih.-  |  02/03/2012
            If frmMain.Visible Then frmMain.Escuch.Caption = CStr(NumUsers)
            
            Call CloseUser(UserIndex)
            
            'Call EstadisticasWeb.Informar(CANTIDAD_ONLINE, NumUsers)
        Else
            Call ResetUserSlot(UserIndex)
        End If
        
        .ConnID = -1
        .ConnIDValida = False
        
        
        If UserIndex = LastUser Then
            Do Until UserList(LastUser).ConnID <> -1
                LastUser = LastUser - 1
                If LastUser < 1 Then Exit Do
            Loop
        End If
    End With
    
Exit Sub

ErrHandler:
    UserList(UserIndex).ConnID = -1
    UserList(UserIndex).ConnIDValida = False
    Call ResetUserSlot(UserIndex)
    
    If UserIndex = LastUser Then
        Do Until UserList(LastUser).ConnID <> -1
            LastUser = LastUser - 1
            If LastUser < 1 Then Exit Do
        Loop
    End If

    Call LogError("CloseSocket - Error = " & Err.Number & " - Descripci�n = " & Err.description & " - UserIndex = " & UserIndex)
End Sub

#ElseIf UsarQueSocket = 0 Then

Sub CloseSocket(ByVal UserIndex As Integer)
'***************************************************
'Author: Unknownn
'Last Modification: -
'
'***************************************************

On Error GoTo ErrHandler
    
    
    
    UserList(UserIndex).ConnID = -1

    If UserIndex = LastUser And LastUser > 1 Then
        Do Until UserList(LastUser).flags.UserLogged
            LastUser = LastUser - 1
            If LastUser <= 1 Then Exit Do
        Loop
    End If

    If UserList(UserIndex).flags.UserLogged Then
            If NumUsers <> 0 Then NumUsers = NumUsers - 1
            Call CloseUser(UserIndex)
    End If

    frmMain.Socket2(UserIndex).Cleanup
    Unload frmMain.Socket2(UserIndex)
    Call ResetUserSlot(UserIndex)

Exit Sub

ErrHandler:
    UserList(UserIndex).ConnID = -1
    Call ResetUserSlot(UserIndex)
End Sub


#ElseIf UsarQueSocket = 3 Then

Sub CloseSocket(ByVal UserIndex As Integer, Optional ByVal cerrarlo As Boolean = True)
'***************************************************
'Author: Unknownn
'Last Modification: -
'
'***************************************************
On Error GoTo ErrHandler

Dim NURestados As Boolean
Dim CoNnEcTiOnId As Long


    NURestados = False
    CoNnEcTiOnId = UserList(UserIndex).ConnID
    
    'call logindex(UserIndex, "******> Sub CloseSocket. ConnId: " & CoNnEcTiOnId & " Cerrarlo: " & Cerrarlo)
    
    
  
    UserList(UserIndex).ConnID = -1 'inabilitamos operaciones en socket

    If UserIndex = LastUser And LastUser > 1 Then
        Do
            LastUser = LastUser - 1
            If LastUser <= 1 Then Exit Do
        Loop While UserList(LastUser).flags.UserLogged = True
    End If

    If UserList(UserIndex).flags.UserLogged Then
            If NumUsers <> 0 Then NumUsers = NumUsers - 1
            NURestados = True
            Call CloseUser(UserIndex)
    End If
    
    Call ResetUserSlot(UserIndex)
    
    'limpiada la userlist... reseteo el socket, si me lo piden
    'Me lo piden desde: cerrada intecional del servidor (casi todas
    'las llamadas a CloseSocket del codigo)
    'No me lo piden desde: disconnect remoto (el on_close del control
    'de alejo realiza la desconexion automaticamente). Esto puede pasar
    'por ejemplo, si el cliente cierra el AO.
    If cerrarlo Then Call frmMain.TCPServ.CerrarSocket(CoNnEcTiOnId)

Exit Sub

ErrHandler:
    Call LogError("CLOSESOCKETERR: " & Err.description & " UI:" & UserIndex)
    
    If Not NURestados Then
        If UserList(UserIndex).flags.UserLogged Then
            If NumUsers > 0 Then
                NumUsers = NumUsers - 1
            End If
            Call LogError("Cerre sin grabar a: " & UserList(UserIndex).Name)
        End If
    End If
    
    Call LogError("El usuario no guardado ten�a connid " & CoNnEcTiOnId & ". Socket no liberado.")
    Call ResetUserSlot(UserIndex)

End Sub


#End If

'[Alejo-21-5]: Cierra un socket sin limpiar el slot
Sub CloseSocketSL(ByVal UserIndex As Integer)
'***************************************************
'Author: Unknownn
'Last Modification: -
'
'***************************************************

#If UsarQueSocket = 1 Then

If UserList(UserIndex).ConnID <> -1 And UserList(UserIndex).ConnIDValida Then
    Call BorraSlotSock(UserList(UserIndex).ConnID)
    Call WSApiCloseSocket(UserList(UserIndex).ConnID)
    UserList(UserIndex).ConnIDValida = False
End If

#ElseIf UsarQueSocket = 0 Then

If UserList(UserIndex).ConnID <> -1 And UserList(UserIndex).ConnIDValida Then
    frmMain.Socket2(UserIndex).Cleanup
    Unload frmMain.Socket2(UserIndex)
    UserList(UserIndex).ConnIDValida = False
End If

#ElseIf UsarQueSocket = 2 Then

If UserList(UserIndex).ConnID <> -1 And UserList(UserIndex).ConnIDValida Then
    Call frmMain.Serv.CerrarSocket(UserList(UserIndex).ConnID)
    UserList(UserIndex).ConnIDValida = False
End If

#End If
End Sub

''
' Send an string to a Slot
'
' @param userIndex The index of the User
' @param Datos The string that will be send
' @remarks If UsarQueSocket is 3 it won`t use the clsByteQueue

Public Function EnviarDatosASlot(ByVal UserIndex As Integer, ByRef Datos As String) As Long
'***************************************************
'Author: Unknownn
'Last Modification: 15/10/2011 - ^[GS]^
'Last Modified By: Lucas Tavolaro Ortiz (Tavo)
'Now it uses the clsByteQueue class and don`t make a FIFO Queue of String
'***************************************************

#If UsarQueSocket = 1 Then '**********************************************
    On Error GoTo Err
    
    Dim ret As Long
    
    ret = WsApiEnviar(UserIndex, Datos)
    
    If ret <> 0 And ret <> WSAEWOULDBLOCK Then
        ' Close the socket avoiding any critical error
        Call CloseSocketSL(UserIndex)
        Call Cerrar_Usuario(UserIndex)
    End If
Exit Function
    
Err:

#ElseIf UsarQueSocket = 0 Then '**********************************************
    
    If frmMain.Socket2(UserIndex).Write(Datos, Len(Datos)) < 0 Then
        If frmMain.Socket2(UserIndex).LastError = WSAEWOULDBLOCK Then
            ' WSAEWOULDBLOCK, put the data again in the outgoingData Buffer
            Call UserList(UserIndex).outgoingData.WriteASCIIStringFixed(Datos)
        Else
            'Close the socket avoiding any critical error
            Call Cerrar_Usuario(UserIndex)
        End If
    End If
#ElseIf UsarQueSocket = 2 Then '**********************************************

    'Return value for this Socket:
    '--0) OK
    '--1) WSAEWOULDBLOCK
    '--2) ERROR
    
    Dim ret As Long

    ret = frmMain.Serv.Enviar(.ConnID, Datos, Len(Datos))
            
    If ret = 1 Then
        ' WSAEWOULDBLOCK, put the data again in the outgoingData Buffer
        Call .outgoingData.WriteASCIIStringFixed(Datos)
    ElseIf ret = 2 Then
        'Close socket avoiding any critical error
        Call CloseSocketSL(UserIndex)
        Call Cerrar_Usuario(UserIndex)
    End If
    

#ElseIf UsarQueSocket = 3 Then
    'THIS SOCKET DOESN`T USE THE BYTE QUEUE CLASS
    
    'al carajo, esto encola solo!!! che, me aprobar� los
    'parciales tambi�n?, este control hace todo solo!!!!
    On Error GoTo ErrorHandler
        
        If UserList(UserIndex).ConnID = -1 Then
            Call LogError("TCP::EnviardatosASlot, se intento enviar datos a un userIndex con ConnId=-1")
            Exit Function
        End If
        
        If frmMain.TCPServ.Enviar(UserList(UserIndex).ConnID, Datos, Len(Datos)) = 2 Then Call CloseSocket(UserIndex)

Exit Function
ErrorHandler:
    Call LogError("TCP::EnviarDatosASlot. UI/ConnId/Datos: " & UserIndex & "/" & UserList(UserIndex).ConnID & "/" & Datos)
#End If '**********************************************

End Function
Function EstaPCarea(Index As Integer, Index2 As Integer) As Boolean
'***************************************************
'Author: Unknownn
'Last Modification: -
'
'***************************************************

Dim X As Integer, Y As Integer
For Y = UserList(Index).Pos.Y - MinYBorder + 1 To UserList(Index).Pos.Y + MinYBorder - 1
        For X = UserList(Index).Pos.X - MinXBorder + 1 To UserList(Index).Pos.X + MinXBorder - 1

            If MapData(UserList(Index).Pos.Map, X, Y).UserIndex = Index2 Then
                EstaPCarea = True
                Exit Function
            End If
        
        Next X
Next Y
EstaPCarea = False
End Function

Function HayPCarea(Pos As WorldPos) As Boolean
'***************************************************
'Author: Unknownn
'Last Modification: -
'
'***************************************************

Dim X As Integer, Y As Integer
For Y = Pos.Y - MinYBorder + 1 To Pos.Y + MinYBorder - 1
        For X = Pos.X - MinXBorder + 1 To Pos.X + MinXBorder - 1
            If X > 0 And Y > 0 And X < 101 And Y < 101 Then
                If MapData(Pos.Map, X, Y).UserIndex > 0 Then
                    HayPCarea = True
                    Exit Function
                End If
            End If
        Next X
Next Y
HayPCarea = False
End Function

Function HayOBJarea(Pos As WorldPos, ObjIndex As Integer) As Boolean
'***************************************************
'Author: Unknownn
'Last Modification: -
'
'***************************************************

Dim X As Integer, Y As Integer
For Y = Pos.Y - MinYBorder + 1 To Pos.Y + MinYBorder - 1
        For X = Pos.X - MinXBorder + 1 To Pos.X + MinXBorder - 1
            If MapData(Pos.Map, X, Y).ObjInfo.ObjIndex = ObjIndex Then
                HayOBJarea = True
                Exit Function
            End If
        
        Next X
Next Y
HayOBJarea = False
End Function
Function ValidateChr(ByVal UserIndex As Integer) As Boolean
'***************************************************
'Author: Unknownn
'Last Modification: -
'
'***************************************************

ValidateChr = UserList(UserIndex).Char.Head <> 0 And UserList(UserIndex).Char.Body <> 0 And ValidateSkills(UserIndex)

End Function

Public Function ConnectUser(ByVal UserIndex As Integer, ByRef Name As String, ByVal Password As String, ByVal SerialHD As String) As Boolean
'***************************************************
'Autor: Unknown (orginal version)
'Last Modification: 12/08/2014 - ^[GS]^
'
'***************************************************
Dim N As Integer
Dim tStr As String

ConnectUser = False ' Por defecto, es FALSE

With UserList(UserIndex)

    If .flags.UserLogged Then
        Call LogCheating("El usuario " & .Name & " ha intentado loguear a " & Name & " desde la IP " & .ip)
        'Kick player ( and leave character inside :D )!
        Call CloseSocketSL(UserIndex)
        Call Cerrar_Usuario(UserIndex)
        Exit Function
    End If
    
    'Reseteamos los FLAGS
    .flags.Escondido = 0
    .flags.TargetNPC = 0
    .flags.TargetNpcTipo = eNPCType.Comun
    .flags.targetObj = 0
    .flags.targetUser = 0
    .flags.FormYesNoType = 0 ' GSZAO
    .flags.FormYesNoA = 0 ' GSZAO
    .flags.FormYesNoDE = 0 ' GSZAO
    .flags.SerialHD = SerialHD ' GSZ-AO
    .Char.FX = 0
    
    'Controlamos no pasar el maximo de usuarios
    If NumUsers >= iniMaxUsuarios Then
        Call WriteErrorMsg(UserIndex, "El servidor ha alcanzado el m�ximo de usuarios soportado, por favor vuelva a intertarlo m�s tarde.")
        Call FlushBuffer(UserIndex)
        Call CloseSocket(UserIndex)
        Exit Function
    End If
    
    '�Este IP ya esta conectado?
    If iniMultiLogin = 0 Then
        If CheckForSameIP(UserIndex, .ip) = True Then
            Call WriteErrorMsg(UserIndex, "No es posible usar m�s de un personaje al mismo tiempo.")
            Call FlushBuffer(UserIndex)
            Call CloseSocket(UserIndex)
            Exit Function
        End If
    End If
    
   '�Este HD ya esta conectado?
    If iniMultiLogin = 0 Then ' GSZAO
        If CheckForSameHD(UserIndex, SerialHD) = True Then
            Call WriteErrorMsg(UserIndex, "No es posible usar m�s de un personaje al mismo tiempo.")
            Call FlushBuffer(UserIndex)
            Call CloseSocket(UserIndex)
            Exit Function
        End If
    End If
    
    '�Existe el personaje?
    If Not FileExist(CharPath & UCase$(Name) & ".chr", vbNormal) Then
        Call WriteErrorMsg(UserIndex, "El personaje no existe.")
        Call FlushBuffer(UserIndex)
        Call CloseSocket(UserIndex)
        Exit Function
    End If
       
    '�Es el passwd valido?
    If UCase$(Password) <> UCase$(GetVar(CharPath & UCase$(Name) & ".chr", "INIT", "Password")) Then
        Call WriteErrorMsg(UserIndex, "Password incorrecto.")
        Call FlushBuffer(UserIndex)
        Call CloseSocket(UserIndex)
        Exit Function
    End If
    
    '�Ya esta conectado el personaje?
    If CheckForSameName(Name) Then
        If UserList(NameIndex(Name)).Counters.Saliendo Then
            Call WriteErrorMsg(UserIndex, "El usuario est� saliendo.")
        Else
            Call WriteErrorMsg(UserIndex, "Perd�n, un usuario con el mismo nombre ya se encuentra logueado.")
        End If
        Call FlushBuffer(UserIndex)
        Call CloseSocket(UserIndex)
        Exit Function
    End If
    
    'Reseteamos los privilegios
    .flags.Privilegios = 0
    
    'Vemos que clase de user es (se lo usa para setear los privilegios al loguear el PJ)
    If EsAdmin(Name) Then
        .flags.Privilegios = .flags.Privilegios Or PlayerType.Admin
        Call LogGM(Name, "Se conecto con IP: " & .ip)
    ElseIf EsDios(Name) Then
        .flags.Privilegios = .flags.Privilegios Or PlayerType.Dios
        Call LogGM(Name, "Se conecto con IP: " & .ip)
    ElseIf EsSemiDios(Name) Then
        .flags.Privilegios = .flags.Privilegios Or PlayerType.SemiDios
        Call LogGM(Name, "Se conecto con IP: " & .ip)
        .flags.PrivEspecial = EsGmEspecial(Name) ' 0.13.3
    ElseIf EsConsejero(Name) Then
        .flags.Privilegios = .flags.Privilegios Or PlayerType.Consejero
        Call LogGM(Name, "Se conecto con IP: " & .ip)
    Else
        .flags.Privilegios = .flags.Privilegios Or PlayerType.User
        .flags.AdminPerseguible = True
    End If
    
    'Add RM flag if needed
    If EsRolesMaster(Name) Then
        .flags.Privilegios = .flags.Privilegios Or PlayerType.RoleMaster
    End If
    
    If iniSoloGMs > 0 Then
        If (.flags.Privilegios And (PlayerType.Admin Or PlayerType.Dios Or PlayerType.SemiDios Or PlayerType.Consejero)) = 0 Then
            Call WriteErrorMsg(UserIndex, "Servidor restringido solo a Administradores. Por favor, vuelva a intentarlo en otro momento.")
            Call FlushBuffer(UserIndex)
            Call CloseSocket(UserIndex)
            Exit Function
        End If
    End If
    
    'Lectura de Datos (FEDUDOK)
    #If Mysql = 0 Then
        'Cargamos el personaje
        Dim Leer As clsIniManager
        Set Leer = New clsIniManager
        Call Leer.Initialize(CharPath & UCase$(Name) & ".chr")
        'Cargamos los datos del personaje
        Call LoadUserInit(UserIndex, Leer)
        Call LoadUserStats(UserIndex, Leer)
        Call LoadUserReputacion(UserIndex, Leer)
        Call LoadQuestStats(UserIndex, Leer) ' GSZAO
        Set Leer = Nothing
    #Else
        Call LoadUserSQL(UserIndex, Name)
    #End If
    
    If Not ValidateChr(UserIndex) Then
        Call WriteErrorMsg(UserIndex, "Error en el personaje.")
        Call CloseSocket(UserIndex)
        Exit Function
    End If
    
    ' Servidor en modo pruebas
    If iniTesting And .Stats.ELV >= 18 Then
        Call WriteErrorMsg(UserIndex, "Servidor en Modo de Pruebas, conectese con personaje de nivel menor a 18. No se conecte con personajes que puedan resultar importantes por ahora pues pueden arruinarse.")
        Call FlushBuffer(UserIndex)
        Call CloseSocket(UserIndex)
        Exit Function
    End If
    
    ' Configuraci�n especial del cliente
    Call WriteClientConfig(UserIndex)   ' GSZAO
    
    .Name = Name ' Nombre del jugador
    .ShowName = True 'Por default los nombres son visibles
    
    ' Definimos el color del nick
    If .flags.Privilegios = PlayerType.Dios Then
        .flags.ChatColor = RGB(250, 250, 150)
    ElseIf .flags.Privilegios <> PlayerType.User And .flags.Privilegios <> (PlayerType.User Or PlayerType.ChaosCouncil) And .flags.Privilegios <> (PlayerType.User Or PlayerType.RoyalCouncil) Then
        .flags.ChatColor = RGB(0, 255, 0)
    ElseIf .flags.Privilegios = (PlayerType.User Or PlayerType.RoyalCouncil) Then
        .flags.ChatColor = RGB(0, 255, 255)
    ElseIf .flags.Privilegios = (PlayerType.User Or PlayerType.ChaosCouncil) Then
        .flags.ChatColor = RGB(255, 128, 64)
    Else
        .flags.ChatColor = vbWhite
    End If
    
    If (.flags.Privilegios And (PlayerType.User Or PlayerType.RoleMaster)) = 0 Then ' 0.13.3
        'Call DoAdminInvisible(UserIndex) ' Hace que los administradores se conectaran invisibles
        .flags.SendDenounces = True 'Activa el envio de denuncias por consola
    End If
    
    ' Valores de inventario de base
    If .Invent.EscudoEqpSlot = 0 Then .Char.ShieldAnim = NingunEscudo
    If .Invent.CascoEqpSlot = 0 Then .Char.CascoAnim = NingunCasco
    If .Invent.WeaponEqpSlot = 0 Then .Char.WeaponAnim = NingunArma
    ' �Tiene Mochila?
    If .Invent.MochilaEqpSlot > 0 Then
        .CurrentInventorySlots = MAX_NORMAL_INVENTORY_SLOTS + ObjData(.Invent.Object(.Invent.MochilaEqpSlot).ObjIndex).MochilaType * 5
    Else
        .CurrentInventorySlots = MAX_NORMAL_INVENTORY_SLOTS
    End If
    
    ' �Seguro de resucitaci�n?
    'If (.flags.Muerto = 0) Then
    '    .flags.SeguroResu = False ' Est� muerto, por defecto el seguro esta deshabilitado
    '    Call WriteMultiMessage(UserIndex, eMessages.ResuscitationSafeOff)
    'Else
    '    .flags.SeguroResu = True ' Si est� vivo e inicia, el seguro esta habilitado
    '    Call WriteMultiMessage(UserIndex, eMessages.ResuscitationSafeOn)
    'End If
    ' SIEMPRE se inicia con el Seguro de Resurecci�n activado
    .flags.SeguroResu = True ' Si est� vivo e inicia, el seguro esta habilitado
    Call WriteMultiMessage(UserIndex, eMessages.ResuscitationSafeOn)
           
    ' Le enviamos el n�mero de Userindex (en el servidor)
    Call WriteUserIndexInServer(UserIndex)
                    
    ' Posici�n de inicio al loguear
    Dim mapa As Integer
    mapa = .Pos.Map
    If mapa = 0 Then ' todo a 1 por defecto...
        .Pos.Map = 1
        .Pos.X = 50
        .Pos.Y = 50
        mapa = 1 ' por defecto!
    Else
        If Not MapaValido(mapa) Then
            Call WriteErrorMsg(UserIndex, "El personaje se encuenta en un mapa inv�lido.")
            Call FlushBuffer(UserIndex)
            Call CloseSocket(UserIndex)
            Exit Function
        End If
    
        ' If map has different initial coords, update it
        Dim StartMap As Integer
        StartMap = MapInfo(mapa).StartPos.Map
        If StartMap <> 0 Then
            If MapaValido(StartMap) Then
                .Pos = MapInfo(mapa).StartPos
                mapa = StartMap
            End If
        End If
    End If
    
    'Tratamos de evitar en lo posible el "Telefrag". Solo 1 intento de loguear en pos adjacentes.
    'Codigo por Pablo (ToxicWaste) y revisado por Nacho (Integer), corregido para que realmetne ande y no tire el server por Juan Mart�n Sotuyo Dodero (Maraxus)
    If MapData(mapa, .Pos.X, .Pos.Y).UserIndex <> 0 Or MapData(mapa, .Pos.X, .Pos.Y).NpcIndex <> 0 Then
        Dim FoundPlace As Boolean
        Dim esAgua As Boolean
        Dim tX As Long
        Dim tY As Long
        
        FoundPlace = False
        esAgua = HayAgua(mapa, .Pos.X, .Pos.Y)
        
        For tY = .Pos.Y - 1 To .Pos.Y + 1
            For tX = .Pos.X - 1 To .Pos.X + 1
                If esAgua Then
                    'reviso que sea pos legal en agua, que no haya User ni NPC para poder loguear.
                    If LegalPos(mapa, tX, tY, True, False) Then
                        FoundPlace = True
                        Exit For
                    End If
                Else
                    'reviso que sea pos legal en tierra, que no haya User ni NPC para poder loguear.
                    If LegalPos(mapa, tX, tY, False, True) Then
                        FoundPlace = True
                        Exit For
                    End If
                End If
            Next tX
            
            If FoundPlace Then Exit For
        Next tY
        
        If FoundPlace Then 'Si encontramos un lugar, listo, nos quedamos ahi
            .Pos.X = tX
            .Pos.Y = tY
        Else
            'Si no encontramos un lugar, sacamos al usuario que tenemos abajo, y si es un NPC, lo pisamos.
            If MapData(mapa, .Pos.X, .Pos.Y).UserIndex <> 0 Then
               'Si no encontramos lugar, y abajo teniamos a un usuario, lo pisamos y cerramos su comercio seguro
                If UserList(MapData(mapa, .Pos.X, .Pos.Y).UserIndex).ComUsu.DestUsu > 0 Then
                    'Le avisamos al que estaba comerciando que se tuvo que ir.
                    If UserList(UserList(MapData(mapa, .Pos.X, .Pos.Y).UserIndex).ComUsu.DestUsu).flags.UserLogged Then
                        Call FinComerciarUsu(UserList(MapData(mapa, .Pos.X, .Pos.Y).UserIndex).ComUsu.DestUsu)
                        Call WriteMensajes(UserList(MapData(mapa, .Pos.X, .Pos.Y).UserIndex).ComUsu.DestUsu, eMensajes.Mensaje031) ' "Comercio cancelado. El otro usuario se ha desconectado."
                        Call FlushBuffer(UserList(MapData(mapa, .Pos.X, .Pos.Y).UserIndex).ComUsu.DestUsu)
                    End If
                    'Lo sacamos.
                    If UserList(MapData(mapa, .Pos.X, .Pos.Y).UserIndex).flags.UserLogged Then
                        Call FinComerciarUsu(MapData(mapa, .Pos.X, .Pos.Y).UserIndex)
                        Call WriteErrorMsg(MapData(mapa, .Pos.X, .Pos.Y).UserIndex, "Alguien se ha conectado donde te encontrabas, por favor, vuelve a conectarte...")
                        Call FlushBuffer(MapData(mapa, .Pos.X, .Pos.Y).UserIndex)
                    End If
                End If
                
                Call CloseSocket(MapData(mapa, .Pos.X, .Pos.Y).UserIndex)
            End If
        End If
    End If
               
    'If in the water, and has a boat, equip it!
    If .Invent.BarcoObjIndex > 0 And _
            (HayAgua(mapa, .Pos.X, .Pos.Y) Or BodyIsBoat(.Char.Body)) Then
        .Char.Head = 0
        If .flags.Muerto = 0 Then
            Call ToggleBoatBody(UserIndex)
        Else
            .Char.Body = iFragataFantasmal
            .Char.ShieldAnim = NingunEscudo
            .Char.WeaponAnim = NingunArma
            .Char.CascoAnim = NingunCasco
        End If
        
        .flags.Navegando = 1
    End If
    
    ' �Esta navegando?
    If .flags.Navegando = 1 Then
        Call WriteNavigateToggle(UserIndex)
    End If
           
    ' �Est� paralizado?
    If .flags.Paralizado Then
        Call WriteParalizeOK(UserIndex)
    End If
                   
    Call WriteChangeMap(UserIndex, .Pos.Map, MapInfo(.Pos.Map).MapVersion) ' Cargamos el mapa
    Call WritePlayMidi(UserIndex, val(ReadField(1, MapInfo(.Pos.Map).Music, 45))) ' Cargamos la musica del mapa
    
    ' Crea el personaje del usuario logueado
    If Not MakeUserChar(True, .Pos.Map, UserIndex, .Pos.Map, .Pos.X, .Pos.Y) Then ' 0.13.5
        Call LogError("ConnectUser::Error MakeUserChar - UserIndex: " & UserIndex)
        Exit Function
    End If
    
    ' Le enviamos el n�mero de UserCharIndex (en el servidor)
    Call WriteUserCharIndexInServer(UserIndex)
        
    Call CheckUserLevel(UserIndex) ' �Pas� de nivel por experiencia estando offline?
    Call WriteUpdateUserStats(UserIndex) ' Vida, Mana, Stamina, Oro, Exp, Nivel
    Call WriteUpdateHungerAndThirst(UserIndex) ' Hambre y Agua
    Call WriteUpdateStrenghtAndDexterity(UserIndex) ' Fuerza y Agilidad

    Call UpdateUserInv(True, UserIndex, 0) ' Enviamos inventario de objetos
    Call UpdateUserHechizos(True, UserIndex, 0) ' Enviamos inventario de hechizos
        
    'Actualiza el Num de usuarios
    NumUsers = NumUsers + 1
    If frmMain.Visible Then frmMain.Escuch.Caption = CStr(NumUsers)
    
    ' Usuario logueado
    .flags.UserLogged = True
    Call WriteVar(CharPath & .Name & ".chr", "INIT", "Logged", "1")
    
    ' Usuarios en el mapa
    MapInfo(.Pos.Map).NumUsers = MapInfo(.Pos.Map).NumUsers + 1
        
    If NumUsers > iniRecord Then
        Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("Record de usuarios conectados simultaneamente." & "Hay " & NumUsers & " modUsuarios.", FontTypeNames.FONTTYPE_INFO))
        iniRecord = NumUsers
        'Actualizo el frmMain. / maTih.-  |  02/03/2012
        If frmMain.Visible Then frmMain.Record.Caption = CStr(NumUsers)
        
        Call WriteVar(IniPath & "Servidor.ini", "INIT", "Record", str(iniRecord))
    End If
        
    ' Los criminales inician con el seguro desactivado
    If Criminal(UserIndex) Then
        Call WriteMultiMessage(UserIndex, eMessages.SafeModeOff) 'Call WriteSafeModeOff(UserIndex)
        .flags.Seguro = False
    Else
        .flags.Seguro = True
        Call WriteMultiMessage(UserIndex, eMessages.SafeModeOn) 'Call WriteSafeModeOn(UserIndex)
    End If
    
    ' Tiene Skilles libres? (GSZAO: Loguea mas lento si tiene skilles sin asignar, WHY???!)
    If .Stats.SkillPts > 0 Then
        Call WriteSendSkills(UserIndex) ' Envia los Skilles asignados por el usuario
        Call WriteLevelUp(UserIndex, .Stats.SkillPts) ' Enviamos la informaci�n sobre los Skilles libres
    End If
    
    ' El servidor est� haciendo Backup
    If haciendoBK Then
        Call WritePauseToggle(UserIndex)
        Call WriteMensajes(UserIndex, eMensajes.Mensaje385) '"Servidor> Por favor espera algunos segundos, el WorldSave est� ejecut�ndose."
    End If
    
    ' El servidor esta haciendo una pausa temporal
    If EnPausa Then
        Call WritePauseToggle(UserIndex)
        Call WriteMensajes(UserIndex, eMensajes.Mensaje386) '"Servidor> Lo sentimos mucho pero el servidor se encuentra actualmente detenido. Intenta ingresar m�s tarde."
    End If
    

    ' Le pide al cliente mostrar el frmMain y activa el dibujo del render
    Call WriteLoggedMessage(UserIndex)
    
    ' GSZAO hacemos la animaci�n, luego de que "entre" y as� lo pueda ver :)
    Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageCreateFX(.Char.CharIndex, FXIDs.FXWARP, 0))
            
    ' �Tiene mascotas y el mapa es inseguro?
    If .NroMascotas > 0 And MapInfo(.Pos.Map).Pk Then
        Dim i As Integer
        For i = 1 To MAXMASCOTAS
            If .MascotasType(i) > 0 Then
                .MascotasIndex(i) = SpawnNpc(.MascotasType(i), .Pos, True, True)
                
                If .MascotasIndex(i) > 0 Then
                    Npclist(.MascotasIndex(i)).MaestroUser = UserIndex
                    Call FollowAmo(.MascotasIndex(i))
                Else
                    .MascotasIndex(i) = 0
                End If
            End If
        Next i
    End If
    
    ' �Tiene Clan?
    If .GuildIndex > 0 Then
        'welcome to the show baby...
        If Not modGuilds.m_ConectarMiembroAClan(UserIndex, .GuildIndex) Then
            Call WriteMensajes(UserIndex, eMensajes.Mensaje387) '"Tu estado no te permite entrar al clan."
         Else
            Call SendData(SendTarget.ToDiosesYclan, .GuildIndex, PrepareMessageConsoleMsg(.Name & "> Se ha conectado.", FontTypeNames.FONTTYPE_TALK)) ' GSZAO
        End If
        ' Envia las noticias del clan
        Call modGuilds.SendGuildNews(UserIndex)
    End If
        
    ' Al entrar, esta protegido del ataque de NPCs por 5 segundos, si no realiza ninguna accion
    Call IntervaloPermiteSerAtacado(UserIndex, True)
    
    ' �Est� lloviendo?
    If Lloviendo Then
        Call WriteRainToggle(UserIndex)
    End If
    
    ' �Le rechazaron una solicitud ingreso a algun clan?
    tStr = modGuilds.a_ObtenerRechazoDeChar(.Name)
    If LenB(tStr) <> 0 Then
        Call WriteShowMessageBox(UserIndex, "Tu solicitud de ingreso al clan ha sido rechazada. El clan te explica que: " & tStr)
    End If
    
    ' Envia el mensaje de bienvenida
    Call SendMOTD(UserIndex)
    
    ' �Es GM?
    If EsGm(UserIndex) Then
        Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg("Admins> " & UserList(UserIndex).Name & " se ha conectado", FontTypeNames.FONTTYPE_SERVER)) ' GSZAO
    End If
    
    ' GSZAO: Se asegur� de que el usuario se encuentre en una posici�n valida
    Call DoTileEvents(UserIndex, .Pos.Map, .Pos.X, .Pos.Y)
    
    'Load the user statistics
    Call modStatistics.UserConnected(UserIndex)
    
    'Log's
    N = FreeFile
    Open App.Path & "\Logs\NumUsers.log" For Output As N
    Print #N, NumUsers
    Close #N
    
    N = FreeFile
    Open App.Path & "\Logs\Connect.log" For Append Shared As #N
    Print #N, .Name & " ha entrado al juego. UserIndex:" & UserIndex & " " & time & " " & Date
    Close #N
    
    ConnectUser = True

End With

End Function


Sub SendMOTD(ByVal UserIndex As Integer)
'***************************************************
'Author: Unknownn
'Last Modification: -
'
'***************************************************

    Dim j As Long
    
    Call WriteGuildChat(UserIndex, "Mensajes de entrada:")
    For j = 1 To MaxLines
        Call WriteGuildChat(UserIndex, MOTD(j).texto)
    Next j
End Sub

Sub ResetFacciones(ByVal UserIndex As Integer)
'*************************************************
'Author: Unknownn
'Last modified: 23/01/2007
'Resetea todos los valores generales y las stats
'03/15/2006 Maraxus - Uso de With para mayor performance y claridad.
'23/01/2007 Pablo (ToxicWaste) - Agrego NivelIngreso, FechaIngreso, MatadosIngreso y NextRecompensa.
'*************************************************
    With UserList(UserIndex).fAccion
        .ArmadaReal = 0
        .CiudadanosMatados = 0
        .CriminalesMatados = 0
        .FuerzasCaos = 0
        .FechaIngreso = "No ingres� a ninguna Facci�n"
        .RecibioArmaduraCaos = 0
        .RecibioArmaduraReal = 0
        .RecibioExpInicialCaos = 0
        .RecibioExpInicialReal = 0
        .RecompensasCaos = 0
        .RecompensasReal = 0
        .Reenlistadas = 0
        .NivelIngreso = 0
        .MatadosIngreso = 0
        .NextRecompensa = 0
    End With
End Sub

Sub ResetContadores(ByVal UserIndex As Integer)
'*************************************************
'Author: Unknownn
'Last Modification: 15/10/2011 - ^[GS]^
'Resetea todos los valores generales y las stats
'03/15/2006 Maraxus - Uso de With para mayor performance y claridad.
'05/20/2007 Integer - Agregue todas las variables que faltaban.
'10/07/2010: ZaMa - Agrego los counters que faltaban.
'*************************************************
    With UserList(UserIndex).Counters
        .AGUACounter = 0
        .AsignedSkills = 0
        .AttackCounter = 0
        .bPuedeMeditar = True
        .Ceguera = 0
        .COMCounter = 0
        .Estupidez = 0
        .failedUsageAttempts = 0
        .Frio = 0
        .goHome = 0
        .HPCounter = 0
        .IdleCount = 0
        .Invisibilidad = 0
        .Lava = 0
        .Mimetismo = 0
        .Ocultando = 0
        .Paralisis = 0
        .Pena = 0
        .PiqueteC = 0
        .Saliendo = False
        .Salir = 0
        .STACounter = 0
        .TiempoOculto = 0
        .TimerEstadoAtacable = 0
        .TimerGolpeMagia = 0
        .TimerGolpeUsar = 0
        .TimerLanzarSpell = 0
        .TimerMagiaGolpe = 0
        .TimerPerteneceNpc = 0
        .TimerPuedeAtacar = 0
        .TimerPuedeSerAtacado = 0
        .TimerPuedeTrabajar = 0
        .TimerPuedeUsarArco = 0
        .TimerUsar = 0
        .Trabajando = 0
        .Veneno = 0
    End With
End Sub

Sub ResetCharInfo(ByVal UserIndex As Integer)
'*************************************************
'Author: Unknownn
'Last modified: 03/15/2006
'Resetea todos los valores generales y las stats
'03/15/2006 Maraxus - Uso de With para mayor performance y claridad.
'*************************************************
    With UserList(UserIndex).Char
        .Body = 0
        .CascoAnim = 0
        .CharIndex = 0
        .FX = 0
        .Head = 0
        .loops = 0
        .heading = 0
        .loops = 0
        .ShieldAnim = 0
        .WeaponAnim = 0
    End With
End Sub

Sub ResetBasicUserInfo(ByVal UserIndex As Integer)
'*************************************************
'Author: Unknownn
'Last modified: 03/15/2006
'Resetea todos los valores generales y las stats
'03/15/2006 Maraxus - Uso de With para mayor performance y claridad.
'*************************************************
    With UserList(UserIndex)
        .Name = vbNullString
        .desc = vbNullString
        .DescRM = vbNullString
        .Pos.Map = 0
        .Pos.X = 0
        .Pos.Y = 0
        .ip = vbNullString
        .clase = 0
        .Genero = 0
        .Hogar = 0
        .raza = 0
        
        .PartyIndex = 0
        .PartySolicitud = 0
              
        With .Stats
            .Banco = 0
            .ELV = 0
            .ELU = 0
            .Exp = 0
            .def = 0
            '.CriminalesMatados = 0
            .NPCsMuertos = 0
            .UsuariosMatados = 0
            .SkillPts = 0
            .GLD = 0
            .UserAtributos(1) = 0
            .UserAtributos(2) = 0
            .UserAtributos(3) = 0
            .UserAtributos(4) = 0
            .UserAtributos(5) = 0
            .UserAtributosBackUP(1) = 0
            .UserAtributosBackUP(2) = 0
            .UserAtributosBackUP(3) = 0
            .UserAtributosBackUP(4) = 0
            .UserAtributosBackUP(5) = 0
        End With
        
    End With
End Sub

Sub ResetReputacion(ByVal UserIndex As Integer)
'*************************************************
'Author: Unknownn
'Last modified: 03/15/2006
'Resetea todos los valores generales y las stats
'03/15/2006 Maraxus - Uso de With para mayor performance y claridad.
'*************************************************
    With UserList(UserIndex).Reputacion
        .AsesinoRep = 0
        .BandidoRep = 0
        .BurguesRep = 0
        .LadronesRep = 0
        .NobleRep = 0
        .PlebeRep = 0
        .NobleRep = 0
        .Promedio = 0
    End With
End Sub

Sub ResetGuildInfo(ByVal UserIndex As Integer)
'***************************************************
'Author: Unknownn
'Last Modification: -
'
'***************************************************

    If UserList(UserIndex).EscucheClan > 0 Then
        Call modGuilds.GMDejaDeEscucharClan(UserIndex, UserList(UserIndex).EscucheClan)
        UserList(UserIndex).EscucheClan = 0
    End If
    If UserList(UserIndex).GuildIndex > 0 Then
        Call modGuilds.m_DesconectarMiembroDelClan(UserIndex, UserList(UserIndex).GuildIndex)
    End If
    UserList(UserIndex).GuildIndex = 0
End Sub

Sub ResetUserFlags(ByVal UserIndex As Integer)
'*************************************************
'Author: Unknownn
'Last Modification: 02/08/2012 - ^[GS]^
'Resetea todos los valores generales y las stats
'*************************************************
    With UserList(UserIndex).flags
        .Comerciando = False
        .Ban = 0
        .Escondido = 0
        .DuracionEfecto = 0
        .NpcInv = 0
        .StatsChanged = 0
        .TargetNPC = 0
        .TargetNpcTipo = eNPCType.Comun
        .targetObj = 0
        .TargetObjMap = 0
        .TargetObjX = 0
        .TargetObjY = 0
        .targetUser = 0
        .TipoPocion = 0
        .TomoPocion = False
        .Descuento = vbNullString
        .Hambre = 0
        .Sed = 0
        .Descansar = False
        .Vuela = 0
        .Navegando = 0
        .Oculto = 0
        .Envenenado = 0
        .Invisible = 0
        .Paralizado = 0
        .Inmovilizado = 0
        .Maldicion = 0
        .Bendicion = 0
        .Meditando = 0
        .Privilegios = 0
        .PrivEspecial = False
        .PuedeMoverse = 0
        .OldBody = 0
        .OldHead = 0
        .AdminInvisible = 0
        .CaptchaKey = 0
        .CaptchaCode(0) = 0
        .CaptchaCode(1) = 0
        .CaptchaCode(2) = 0
        .CaptchaCode(3) = 0
        .Hechizo = 0
        .TimesWalk = 0
        .StartWalk = 0
        .CountSH = 0
        .Silenciado = 0
        .CentinelaOK = False
        .CentinelaIndex = 0
        .AdminPerseguible = False
        .lastMap = 0
        .Traveling = 0
        .AtacablePor = 0
        .AtacadoPorNpc = 0
        .AtacadoPorUser = 0
        .NoPuedeSerAtacado = False
        .ShareNpcWith = 0
        .EnConsulta = False
        .Ignorado = False
        .SendDenounces = False
        .ParalizedBy = vbNullString
        .ParalizedByIndex = 0
        .ParalizedByNpcIndex = 0
        
        If .OwnedNpc <> 0 Then
            Call PerdioNpc(UserIndex)
        End If

    End With
End Sub

Sub ResetUserSpells(ByVal UserIndex As Integer)
'***************************************************
'Author: Unknownn
'Last Modification: -
'
'***************************************************

    Dim LoopC As Long
    For LoopC = 1 To MAXUSERHECHIZOS
        UserList(UserIndex).Stats.UserHechizos(LoopC) = 0
    Next LoopC
End Sub

Sub ResetUserPets(ByVal UserIndex As Integer)
'***************************************************
'Author: Unknownn
'Last Modification: -
'
'***************************************************

    Dim LoopC As Long
    
    UserList(UserIndex).NroMascotas = 0
        
    For LoopC = 1 To MAXMASCOTAS
        UserList(UserIndex).MascotasIndex(LoopC) = 0
        UserList(UserIndex).MascotasType(LoopC) = 0
    Next LoopC
End Sub

Sub ResetUserBanco(ByVal UserIndex As Integer)
'***************************************************
'Author: Unknownn
'Last Modification: -
'
'***************************************************

    Dim LoopC As Long
    
    For LoopC = 1 To MAX_BANCOINVENTORY_SLOTS
          UserList(UserIndex).BancoInvent.Object(LoopC).Amount = 0
          UserList(UserIndex).BancoInvent.Object(LoopC).Equipped = 0
          UserList(UserIndex).BancoInvent.Object(LoopC).ObjIndex = 0
    Next LoopC
    
    UserList(UserIndex).BancoInvent.NroItems = 0
End Sub

Public Sub LimpiarComercioSeguro(ByVal UserIndex As Integer)
'***************************************************
'Author: Unknownn
'Last Modification: -
'
'***************************************************

    With UserList(UserIndex).ComUsu
        If .DestUsu > 0 Then
            Call FinComerciarUsu(.DestUsu)
            Call FinComerciarUsu(UserIndex)
        End If
    End With
End Sub

Sub ResetUserSlot(ByVal UserIndex As Integer)
'***************************************************
'Author: Unknownn
'Last Modification: 12/08/2014 - ^[GS]^
'
'***************************************************

Dim i As Long

UserList(UserIndex).ConnIDValida = False
UserList(UserIndex).ConnID = -1

Call LimpiarComercioSeguro(UserIndex)
Call ResetFacciones(UserIndex)
Call ResetContadores(UserIndex)
Call ResetGuildInfo(UserIndex)
Call ResetCharInfo(UserIndex)
Call ResetBasicUserInfo(UserIndex)
Call ResetReputacion(UserIndex)
Call ResetUserFlags(UserIndex)
Call LimpiarInventario(UserIndex)
Call ResetUserSpells(UserIndex)
Call ResetUserPets(UserIndex)
Call ResetUserBanco(UserIndex)
Call ResetQuestStats(UserIndex) ' GSZAO

With UserList(UserIndex).ComUsu

    .Acepto = False
    
    For i = 1 To MAX_OFFER_SLOTS
        .cant(i) = 0
        .Objeto(i) = 0
    Next i
    
    .GoldAmount = 0
    .DestNick = vbNullString
    .DestUsu = 0
End With
 
End Sub

Sub CloseUser(ByVal UserIndex As Integer)
'***************************************************
'Author: Unknownn
'Last Modification: 11/08/2014 - ^[GS]^
'
'***************************************************

On Error GoTo ErrHandler

Dim N As Integer
Dim Map As Integer
Dim Name As String
Dim i As Integer

Dim aN As Integer

With UserList(UserIndex)
    aN = .flags.AtacadoPorNpc
    If aN > 0 Then
          Npclist(aN).Movement = Npclist(aN).flags.OldMovement
          Npclist(aN).Hostile = Npclist(aN).flags.OldHostil
          Npclist(aN).flags.AttackedBy = vbNullString
    End If
    aN = .flags.NPCAtacado
    If aN > 0 Then
        If Npclist(aN).flags.AttackedFirstBy = .Name Then
            Npclist(aN).flags.AttackedFirstBy = vbNullString
        End If
    End If

    .flags.AtacadoPorNpc = 0
    .flags.NPCAtacado = 0
    
    ' GSZAO
    If .flags.FormYesNoDE <> 0 Then
        UserList(.flags.FormYesNoDE).flags.FormYesNoA = 0
        .flags.FormYesNoDE = 0
    End If
    If .flags.FormYesNoA <> 0 Then
        UserList(.flags.FormYesNoA).flags.FormYesNoDE = 0
        .flags.FormYesNoA = 0
    End If
    .flags.FormYesNoType = 0 ' GSZAO
    ' GSZAO
    
    Map = .Pos.Map
    Name = UCase$(.Name)
    
    .Char.FX = 0
    .Char.loops = 0
    Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageCreateFX(.Char.CharIndex, 0, 0))
    
    .flags.UserLogged = False
    .Counters.Saliendo = False
    
    'Le devolvemos el body y head originales
    If .flags.AdminInvisible = 1 Then
        .Char.Body = .flags.OldBody
        .Char.Head = .flags.OldHead
        .flags.AdminInvisible = 0
    End If
    
    'si esta en party le devolvemos la experiencia
    If .PartyIndex > 0 Then Call modUsuariosParty.SalirDeParty(UserIndex)
    
    'Save statistics
    Call modStatistics.UserDisconnected(UserIndex)
    
    ' Grabamos el personaje del usuario
    Call SaveUser(UserIndex, CharPath & Name & ".chr")
    
    'usado para borrar Pjs
    Call WriteVar(CharPath & .Name & ".chr", "INIT", "Logged", "0")
    
    'Quitar el dialogo
    'If MapInfo(Map).NumUsers > 0 Then
    '    Call SendToUserArea(UserIndex, "QDL" & .Char.charindex)
    'End If
    
    If MapaValido(Map) Then ' 0.13.5
        If MapInfo(Map).NumUsers > 0 Then
            Call SendData(SendTarget.ToPCAreaButIndex, UserIndex, PrepareMessageRemoveCharDialog(.Char.CharIndex))
        End If
        
        'Update Map Users
        MapInfo(Map).NumUsers = MapInfo(Map).NumUsers - 1
        
        If MapInfo(Map).NumUsers < 0 Then
            MapInfo(Map).NumUsers = 0
        End If
    End If
    
    'Borrar el personaje
    If .Char.CharIndex > 0 Then
        Call EraseUserChar(UserIndex, .flags.AdminInvisible = 1)
    End If
    
    'Borrar mascotas
    For i = 1 To MAXMASCOTAS
        If .MascotasIndex(i) > 0 Then
            If Npclist(.MascotasIndex(i)).flags.NPCActive Then _
                Call QuitarNPC(.MascotasIndex(i))
        End If
    Next i
    
    ' Si el usuario habia dejado un msg en la gm's queue lo borramos
    If Ayuda.Existe(.Name) Then Call Ayuda.Quitar(.Name)
    
    Call ResetUserSlot(UserIndex)
    
    N = FreeFile(1)
    Open App.Path & "\logs\Connect.log" For Append Shared As #N
        Print #N, Name & " ha dejado el juego. " & "User Index:" & UserIndex & " " & time & " " & Date
    Close #N
    
End With

Exit Sub

ErrHandler:
    Dim UserName As String
    If UserIndex > 0 Then UserName = UserList(UserIndex).Name

    Call LogError("Error en CloseUser. N�mero " & Err.Number & " Descripci�n: " & Err.description & _
        ".User: " & UserName & "(" & UserIndex & "). Map: " & Map)

End Sub

Sub ReloadSokcet()
'***************************************************
'Author: Unknownn
'Last Modification: -
'
'***************************************************

On Error GoTo ErrHandler
#If UsarQueSocket = 1 Then

    Call LogApiSock("ReloadSokcet() " & NumUsers & " " & LastUser & " " & iniMaxUsuarios)
    
    If NumUsers <= 0 Then
        Call WSApiReiniciarSockets
    Else
       Call apiclosesocket(SockListen)
       SockListen = ListenForConnect(iniPuerto, hWndMsg, "")
    End If

#ElseIf UsarQueSocket = 0 Then

    frmMain.Socket1.Cleanup
    Call ConfigListeningSocket(frmMain.Socket1, iniPuerto)
    
#ElseIf UsarQueSocket = 2 Then

    

#End If

Exit Sub
ErrHandler:
    Call LogError("Error en CheckSocketState " & Err.Number & ": " & Err.description)

End Sub


Public Sub EcharPjsNoPrivilegiados()
'***************************************************
'Author: Unknownn
'Last Modification: -
'
'***************************************************

    Dim LoopC As Long
    
    For LoopC = 1 To LastUser
        If UserList(LoopC).flags.UserLogged And UserList(LoopC).ConnID >= 0 And UserList(LoopC).ConnIDValida Then
            If UserList(LoopC).flags.Privilegios And PlayerType.User Then
                Call CloseSocket(LoopC)
            End If
        End If
    Next LoopC

End Sub
