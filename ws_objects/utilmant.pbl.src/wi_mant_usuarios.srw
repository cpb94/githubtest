$PBExportHeader$wi_mant_usuarios.srw
forward
global type wi_mant_usuarios from wi_mant_ventanas
end type
type pb_nuevo from picturebutton within wi_mant_usuarios
end type
type gb_1 from groupbox within wi_mant_usuarios
end type
end forward

global type wi_mant_usuarios from wi_mant_ventanas
integer x = 0
integer y = 0
integer width = 2825
integer height = 1532
pb_nuevo pb_nuevo
gb_1 gb_1
end type
global wi_mant_usuarios wi_mant_usuarios

type variables
String vleer = "S"


end variables

event open;call super::open;
//Mantenimientos con clave alfanumerica
tipo_mantenimiento = "C"
valor_empresa = FALSE

istr_parametros.s_titulo_ventana = "Mantenimiento de usuarios"
istr_parametros.s_listado        = "report_usuarios"

This.title=istr_parametros.s_titulo_ventana

 // Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
     istr_parametros.i_nargumentos = 0
	  sle_valor.text=istr_parametros.s_argumentos[2]
	  IF TRIM(sle_valor.text)<>"" AND Not IsNull(sle_valor.text) THEN
        	This.TriggerEvent("ue_recuperar")
     END IF
END IF
end event

event ue_inserta_fila;call super::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"v_usuario",sle_valor.text)
dw_1.setitem(dw_1.getrow(),"v_empresa","1")
dw_1.setitem(dw_1.getrow(),"tiempo_limite","N")
dw_1.setitem(dw_1.getrow(),"v_nivel","0")

end event

event ue_recuperar;// Valores Para Funcion de bloqueo
vleer = "S"
 titulo       =  This.title
 longitud     =  len(trim(codigo_empresa))
 criterio[1]  =  trim(codigo_empresa)+ space(20-longitud)
 longitud     =  len(Trim(sle_valor.text))
 criterio[2]  =  trim(sle_valor.text)+space(20-longitud)
 seleccion    =  criterio[1]+criterio[2]
 tabla        = "usuarios"
 dw_1.Retrieve(sle_valor.Text)
 CALL Super::ue_recuperar






end event

on wi_mant_usuarios.create
int iCurrent
call super::create
this.pb_nuevo=create pb_nuevo
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_nuevo
this.Control[iCurrent+2]=this.gb_1
end on

on wi_mant_usuarios.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_nuevo)
destroy(this.gb_1)
end on

type dw_1 from wi_mant_ventanas`dw_1 within wi_mant_usuarios
integer x = 9
integer y = 184
integer width = 2711
integer height = 1072
string dataobject = "dw_usuarios"
end type

event dw_1::key; bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
 valor_empresa = TRUE
 CHOOSE CASE bus_campo
	CASE "v_grupo"
 		bus_datawindow = "dw_ayuda_utigrupos"
		bus_titulo="AYUDA SELECCION DE GRUPOS"
	CASE "v_idioma"
 		bus_datawindow = "dw_ayuda_idiomas"
		bus_titulo="AYUDA SELECCION DE IDIOMAS"
		valor_empresa = FALSE
	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key

end event

on dw_1::valores_numericos;call wi_mant_ventanas`dw_1::valores_numericos;f_valores_numericos(dw_1,"v_grupo")
end on

event dw_1::rbuttondown; bus_filtro=""
 bus_titulo=""
 valor_empresa = TRUE
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "v_grupo"
 		bus_datawindow = "dw_ayuda_utigrupos"
		bus_titulo="AYUDA SELECCION DE GRUPOS"
      valor_empresa = FALSE
   CASE "v_idioma"
 		bus_datawindow = "dw_ayuda_idiomas"
		bus_titulo="AYUDA SELECCION DE IDIOMAS"
		valor_empresa = FALSE
	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown

end event

event dw_1::itemfocuschanged;call super::itemfocuschanged;String vemp
STring v_dbms,v_servername,v_basedatos,v_userid,v_databasepassword,v_logid,v_logpassword,v_dbparm  

IF vleer = "S" Then
	vemp = dw_1.GetItemString(1,"v_empresa")
	IF Trim(vemp) <> "" Then
		  SELECT uti_empresa_conexion.v_dbms,   
					uti_empresa_conexion.v_servername,   
					uti_empresa_conexion.v_basedatos,   
					uti_empresa_conexion.v_userid,   
					uti_empresa_conexion.v_databasepassword,   
					uti_empresa_conexion.v_logid,   
					uti_empresa_conexion.v_logpassword,   
					uti_empresa_conexion.v_dbparm  
			 INTO :v_dbms,   
					:v_servername,   
					:v_basedatos,   
					:v_userid,   
					:v_databasepassword,   
					:v_logid,   
					:v_logpassword,   
					:v_dbparm  
			 FROM uti_empresa_conexion  
			WHERE uti_empresa_conexion.v_empresa = :vemp   ;
			IF sqlca.sqlcode = 0 Then
			dw_1.SetItem(1,"v_dbms",v_dbms)
			dw_1.SetItem(1,"v_servername",v_servername)
			dw_1.SetItem(1,"v_basedatos",v_basedatos)
			dw_1.SetItem(1,"v_userid",v_userid)
			dw_1.SetItem(1,"v_databasepassword",v_databasepassword)
			dw_1.SetItem(1,"v_logid",v_logid)
			dw_1.SetItem(1,"v_logpassword",v_logpassword)
			dw_1.SetItem(1,"v_dbparm",v_dbparm)
			vleer = "N"
			END IF
	END IF
END IF
end event

event dw_1::clicked;call super::clicked;String v_alt,v_baj,v_mod

if dwo.name = "cb_permisos" then
	v_alt = This.GetItemString(1,"v_altas")
	v_baj = This.GetItemString(1,"v_bajas")
	v_mod = This.GetItemString(1,"v_modificaciones")
	if v_alt = "S" and v_baj = "S" and v_mod = "S" then
		
	else
		messagebox("Atención","No tiene suficientes permisos generales",Exclamation!)
		return
	end if
end if
end event

type st_1 from wi_mant_ventanas`st_1 within wi_mant_usuarios
integer x = 0
integer y = 76
integer width = 265
integer height = 88
string text = "Usuario:"
end type

type cb_insertar from wi_mant_ventanas`cb_insertar within wi_mant_usuarios
integer x = 1659
integer y = 76
integer width = 343
integer height = 84
end type

type cb_borrar from wi_mant_ventanas`cb_borrar within wi_mant_usuarios
integer x = 2007
integer y = 76
integer width = 343
integer height = 84
end type

event cb_borrar::clicked;call super::clicked;String nuevo_usuario

nuevo_usuario = trim(sle_valor.text)

DELETE FROM uti_permisos_ventana WHERE usuario = :nuevo_usuario;
DELETE FROM uti_permisos_menu WHERE usuario = :nuevo_usuario;

MessageBox("Borrado","Borrado finalizado")

end event

type sle_valor from wi_mant_ventanas`sle_valor within wi_mant_usuarios
integer x = 274
integer y = 80
integer width = 1179
boolean bringtotop = true
end type

event sle_valor::getfocus;call super::getfocus;ue_titulo   = "AYUDA SELECCION DE USUARIOS"
ue_datawindow = "dw_ayuda_usuarios"
ue_filtro = ""
valor_empresa = FALSE
isle_campo = this
end event

type cb_salir from wi_mant_ventanas`cb_salir within wi_mant_usuarios
integer x = 2354
integer y = 76
integer width = 343
integer height = 84
end type

type control_tabulador from wi_mant_ventanas`control_tabulador within wi_mant_usuarios
end type

type pb_nuevo from picturebutton within wi_mant_usuarios
integer x = 1509
integer y = 72
integer width = 110
integer height = 96
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
boolean originalsize = true
string picturename = "Compute!"
alignment htextalign = left!
string powertiptext = "Nuevo usuario"
end type

event clicked;Long existe, i, numero, cod
String nuevo_usuario, sel
Datastore ventanas, menus

if trim(sle_valor.text) = "" then
	Messagebox("Error", "Debe introducir un nombre para el nuevo usuario")
	return
end if

nuevo_usuario = trim(sle_valor.text)

SELECT COUNT(*) INTO :existe FROM usuarios WHERE v_usuario = :nuevo_usuario;

if existe = 0 then
	INSERT INTO usuarios 
			(v_usuario, v_empresa, v_password, v_dbms, v_servername, v_basedatos, v_grupo, v_idioma, v_nivel, 
			v_altas, v_bajas, v_modificaciones, tiempo_limite) 
	VALUES
			(:nuevo_usuario, :codigo_empresa, '', 'SQL Server 2008', 'OBI', 'TENCER', '1', '1', '1', 
			'S', 'S', 'S', 'N');
	
	DELETE FROM uti_permisos_menu WHERE empresa = :codigo_empresa AND usuario = :nuevo_usuario;
	DELETE FROM uti_permisos_ventana WHERE empresa = :codigo_empresa AND usuario = :nuevo_usuario;
	
	//Permisos
	sel = "SELECT codigo FROM uti_ventana WHERE empresa = '"+codigo_empresa+"'"
	f_cargar_cursor_trans (SQLCA,  sel,  ventanas)
	numero = ventanas.RowCount()
	for i = 1 to numero
		cod = ventanas.object.codigo[i]
		INSERT INTO uti_permisos_ventana (ventana, usuario, empresa, permiso) values (:cod, :nuevo_usuario, :codigo_empresa, 0);
	next
	
	sel = "SELECT codigo FROM uti_menu WHERE empresa = '"+codigo_empresa+"' AND menu IS NOT NULL"
	f_cargar_cursor_trans (SQLCA,  sel,  menus)
	numero = menus.RowCount()
	for i = 1 to numero
		cod = menus.object.codigo[i]
		INSERT INTO uti_permisos_menu (menu, usuario, empresa, permiso) values (:cod, :nuevo_usuario, :codigo_empresa, 0);
	next
	sle_valor.triggerevent("tecla_tabulador")
end if

Destroy ventanas
Destroy menus
end event

type gb_1 from groupbox within wi_mant_usuarios
integer x = 1646
integer y = 40
integer width = 1065
integer height = 132
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
end type

