$PBExportHeader$w_int_toma_inventario_compras.srw
forward
global type w_int_toma_inventario_compras from w_int_con_empresa
end type
type cb_1 from u_boton within w_int_toma_inventario_compras
end type
type uo_marca_lista from u_marca_lista within w_int_toma_inventario_compras
end type
type st_1 from statictext within w_int_toma_inventario_compras
end type
type em_fecha from u_em_campo within w_int_toma_inventario_compras
end type
type pb_1 from upb_salir within w_int_toma_inventario_compras
end type
type dw_tomas from datawindow within w_int_toma_inventario_compras
end type
type report_almtoma from datawindow within w_int_toma_inventario_compras
end type
type pb_2 from upb_imprimir within w_int_toma_inventario_compras
end type
type pb_borrar from upb_papelera within w_int_toma_inventario_compras
end type
type ddlb_1 from dropdownlistbox within w_int_toma_inventario_compras
end type
type gb_1 from groupbox within w_int_toma_inventario_compras
end type
end forward

global type w_int_toma_inventario_compras from w_int_con_empresa
integer width = 2871
integer height = 1596
string icon = "Application!"
cb_1 cb_1
uo_marca_lista uo_marca_lista
st_1 st_1
em_fecha em_fecha
pb_1 pb_1
dw_tomas dw_tomas
report_almtoma report_almtoma
pb_2 pb_2
pb_borrar pb_borrar
ddlb_1 ddlb_1
gb_1 gb_1
end type
global w_int_toma_inventario_compras w_int_toma_inventario_compras

type variables
string filtro
integer anyo
end variables

forward prototypes
public function boolean toma_inv (string arg_codigo_empresa, string arg_codigo_almacen, date arg_fecha)
end prototypes

public function boolean toma_inv (string arg_codigo_empresa, string arg_codigo_almacen, date arg_fecha);boolean  bien = true
long     lineas_toma,indice,total,fila,altura,linea,anyo_toma,orden
string   sel,almacen,zona,mp,familia,calidad,envase_real, actualizado
string   ubicacion,tipo_unidad,observaciones,envase_toma
dec		existencias_toma,precio, existencias_reales
datetime fecha_inventario,fecha_actualizado
datastore ubicaciones

fecha_inventario = datetime(arg_fecha)

select count(*)
into   :lineas_toma
from   com_toma_inventario
where  empresa = :codigo_empresa
and    almacen = :arg_codigo_almacen
and    fecha_inventario = :fecha_inventario;

if isnull(lineas_toma) then lineas_toma = 0

if lineas_toma = 0 then
	sel = "SELECT empresa,	 almacen,	    zona,	   fila,"+&
					 "altura, 	 linea, 		    mp, 		   familia,"+&
					 "calidad,   existencias,   ubicacion, tipo_unidad,"+&
					 "f_alta,    observaciones, envase,    precio "+&
			"FROM   comlinubica "+&
			"WHERE  empresa     = '"+arg_codigo_empresa+"' "+&
			"AND    almacen     = '"+arg_codigo_almacen+"'"
	
	//ubicaciones = f_cargar_cursor(sel)
	f_cargar_cursor_nuevo(sel, ubicaciones)
	
	total = ubicaciones.rowcount()
	
	if total > 0 then		
		anyo_toma		  = year(arg_fecha)
		orden            = 1
		almacen          = arg_codigo_almacen
		for indice = 1 to total		
			if bien then
				zona               = ubicaciones.object.zona[indice]
				fila               = ubicaciones.object.fila[indice]
				altura             = ubicaciones.object.altura[indice]
				linea              = ubicaciones.object.linea[indice]
				mp                 = ubicaciones.object.mp[indice]
				familia            = ubicaciones.object.familia[indice]
				calidad            = ubicaciones.object.calidad[indice]
				existencias_toma   = ubicaciones.object.existencias[indice]
				ubicacion          = ubicaciones.object.ubicacion[indice]
				tipo_unidad        = ubicaciones.object.tipo_unidad[indice]
				observaciones      = ubicaciones.object.observaciones[indice]
				envase_toma        = ubicaciones.object.envase[indice]
				precio             = ubicaciones.object.precio[indice]
				existencias_reales = ubicaciones.object.existencias[indice]
				envase_real        = ubicaciones.object.envase[indice]
				actualizado        = "N"
				setnull(fecha_actualizado)
				
				INSERT INTO com_toma_inventario
					(empresa,
					 fecha_inventario,
					 almacen,
					 zona,
					 fila,
					 altura,
					 linea,
					 mp,
					 familia,
					 calidad,
					 existencias_toma,
					 ubicacion,
					 tipo_unidad,
					 observaciones,
					 envase_toma,
					 precio,
					 existencias_reales,					 
					 actualizado,
					 fecha_actualizado,
					 orden,
					 anyo_toma)
				VALUES
					(:codigo_empresa,
					 :fecha_inventario,
					 :almacen,
					 :zona,
					 :fila,
					 :altura,
					 :linea,
					 :mp,
					 :familia,
					 :calidad,
					 :existencias_toma,
					 :ubicacion,
					 :tipo_unidad,
					 :observaciones,
					 :envase_toma,
					 :precio,
					 :existencias_reales,					 
					 :actualizado,
					 :fecha_actualizado,
					 :orden,
					 :anyo_toma);
					 
				if sqlca.sqlcode <> 0 then
					bien = false
				end if			
			end if
		next
	end if
else
	messagebox("Atención","Ya existe una toma a esta fecha para el almacen "+arg_codigo_almacen)
	bien = false
end if
destroy ubicaciones

return bien




end function

event open;call super::open;istr_parametros.s_titulo_ventana="Toma de Inventario del Almacen de Compras"
This.title=istr_parametros.s_titulo_ventana
dw_tomas.SetTransObject(SQLCA)

em_fecha.text=string(today())
Integer registros,x1
String     var_codigo,sel
String     var_texto,marca
integer bien,x2
datastore d
bien=0
x2=0

sel = "SELECT codigo,descripcion  "+&
		"from   comalmacen "+&
		"where  comalmacen.empresa = '"+codigo_empresa+"' "+&
		"order  by descripcion "
				
//d = f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, d)
		
marca     = "S"
registros = d.retrieve(codigo_empresa)
If registros<>0 THEN
	FOR x1= 1 To registros  
		var_codigo  = d.GetItemString(x1,"codigo")
		var_texto   = d.GetItemString(x1,"descripcion")
		uo_marca_lista.dw_marca.InsertRow(x1)
		uo_marca_lista.dw_marca.setitem(x1,"marca",marca)
		uo_marca_lista.dw_marca.setitem(x1,"codigo",var_codigo)
		uo_marca_lista.dw_marca.setitem(x1,"texto",var_texto)
	NEXT
END IF
uo_marca_lista.st_titulo1.text="Almacen"
uo_marca_lista.st_titulo2.text="Texto"
x2 = uo_marca_lista.dw_marca.RowCount()
dw_tomas.Retrieve(codigo_empresa)
dw_tomas.SetRowFocusIndicator(Hand!)		
dw_tomas.Retrieve(codigo_empresa)

ddlb_1.text = "Todos"

destroy d
end event

event ue_listar;String dalm,halm,codalm
datetime fecha_invent

dw_report  = report_almtoma
dw_report.SetTransObject(SQLCA)

if ddlb_1.text = "Todos" then
	dalm = "."
	halm = "Z"
else
	codalm = dw_tomas.GetItemString(dw_tomas.GetRow(),"almacen")
	dalm = codalm
	halm = codalm
End if

fecha_invent =  datetime(date(string(dw_tomas.object.fecha_inventario[dw_tomas.GetRow()], "yyyy-mm-dd")))

dw_report.retrieve(codigo_empresa, fecha_invent, dalm,halm)

IF TRIM(filtro)<>"" THEN
	dw_report.SetFilter(filtro)
	dw_report.Filter()
END IF

CALL Super::ue_listar
end event

on w_int_toma_inventario_compras.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.uo_marca_lista=create uo_marca_lista
this.st_1=create st_1
this.em_fecha=create em_fecha
this.pb_1=create pb_1
this.dw_tomas=create dw_tomas
this.report_almtoma=create report_almtoma
this.pb_2=create pb_2
this.pb_borrar=create pb_borrar
this.ddlb_1=create ddlb_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.uo_marca_lista
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.em_fecha
this.Control[iCurrent+5]=this.pb_1
this.Control[iCurrent+6]=this.dw_tomas
this.Control[iCurrent+7]=this.report_almtoma
this.Control[iCurrent+8]=this.pb_2
this.Control[iCurrent+9]=this.pb_borrar
this.Control[iCurrent+10]=this.ddlb_1
this.Control[iCurrent+11]=this.gb_1
end on

on w_int_toma_inventario_compras.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
destroy(this.uo_marca_lista)
destroy(this.st_1)
destroy(this.em_fecha)
destroy(this.pb_1)
destroy(this.dw_tomas)
destroy(this.report_almtoma)
destroy(this.pb_2)
destroy(this.pb_borrar)
destroy(this.ddlb_1)
destroy(this.gb_1)
end on

event activate;call super::activate;w_int_toma_inventario_compras = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_toma_inventario_compras
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_toma_inventario_compras
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_toma_inventario_compras
integer y = 20
integer width = 2473
integer height = 116
end type

type cb_1 from u_boton within w_int_toma_inventario_compras
integer x = 530
integer y = 180
integer width = 320
integer height = 84
integer taborder = 80
string text = "&Procesar"
end type

event clicked;String mensaje
String  var_codigo
Integer x1
boolean bien = true
integer registros

IF trim(em_fecha.text)="00/00/00" THEN
   mensaje="Introduzca la fecha"
   MessageBox("Campo obligatorio",mensaje,Exclamation!, OK!,1)
   em_fecha.SetFocus()
   RETURN
END IF

registros = uo_marca_lista.dw_marca.RowCount()
IF registros=0 THEN
   mensaje="Marcar algún almacen a procesar"
   MessageBox("Campo obligatorio",mensaje,Exclamation!, OK!,1)
   uo_marca_lista.dw_marca.SetFocus()
   RETURN
END IF

IF Messagebox("Proceso Toma Almacen","¿Desea Procesar la Toma?",Question!,YesNo!,2)= 1 Then
	
	// Comienza el proceso de toma de inventario
	
	//-------------------------------------//
	// Congelamos la ubicacion por almacen //
	//-------------------------------------//		
	IF Not f_bloquear_almacen_compras(Parent.title) Then
		For x1 = 1 To registros
			IF uo_marca_lista.dw_marca.GetItemString(x1,"marca")= "S" THEN
				var_codigo = uo_marca_lista.dw_marca.GetItemString(x1,"codigo")
				IF Trim(String(var_codigo)) <> "" and not(IsNull(var_codigo)) Then
					IF NOT toma_inv(codigo_empresa,var_codigo,Date(em_fecha.text)) THEN
						bien = false
					END IF
				END IF
			END IF
		Next
		IF bien THEN
			COMMIT Using SQLCA;
		ELSE
			ROLLBACK Using SQLCA;
			MessageBox("Atención","La toma no se valida.",Exclamation!, OK!,1)
		END IF	
		f_desbloquear_almacen_compras(Parent.title)
	end if
	dw_tomas.Retrieve(codigo_empresa)
end if
f_activar_campo(em_fecha)

end event

type uo_marca_lista from u_marca_lista within w_int_toma_inventario_compras
integer x = 1463
integer y = 304
integer width = 1367
integer height = 704
integer taborder = 50
boolean border = false
end type

on uo_marca_lista.destroy
call u_marca_lista::destroy
end on

type st_1 from statictext within w_int_toma_inventario_compras
integer x = 5
integer y = 188
integer width = 197
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Fecha"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_fecha from u_em_campo within w_int_toma_inventario_compras
integer x = 215
integer y = 180
integer width = 306
integer taborder = 30
alignment alignment = center!
maskdatatype maskdatatype = datetimemask!
string mask = "dd-mm-yy"
end type

type pb_1 from upb_salir within w_int_toma_inventario_compras
integer x = 2697
integer y = 20
integer width = 119
integer height = 116
integer taborder = 0
end type

type dw_tomas from datawindow within w_int_toma_inventario_compras
integer x = 5
integer y = 304
integer width = 1454
integer height = 1060
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_int_toma_inventario_compras1"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type report_almtoma from datawindow within w_int_toma_inventario_compras
boolean visible = false
integer x = 1957
integer y = 612
integer width = 361
integer height = 156
integer taborder = 60
boolean bringtotop = true
string dataobject = "report_int_toma_inventario_compras"
boolean livescroll = true
end type

type pb_2 from upb_imprimir within w_int_toma_inventario_compras
integer x = 2464
integer y = 1200
integer width = 174
integer height = 152
integer taborder = 0
boolean originalsize = false
string picturename = "print!"
end type

event clicked;filtro=""
Integer registros,x1
String condicion,marca,Sel
//DataStore d
//
//sel = "SELECT codigo,descripcion  "+&
//		"from   comalmacen "+&
//		"where  comalmacen.empresa = '"+codigo_empresa+"' "+&
//		"order  by descripcion "
//				
//d = f_cargar_cursor(sel)

//registros = d.RowCount()
registros = uo_marca_lista.dw_marca.rowcount()

If registros > 0 THEN
	FOR x1= 1 To registros		
		marca = uo_marca_lista.dw_marca.GetItemString(x1,"marca")
		IF marca = "S" THEN
			IF Trim(filtro)<>"" THEN filtro= filtro + " OR "
			condicion = "almacen = '"+uo_marca_lista.dw_marca.GetItemString(x1,"codigo") + "'"
			filtro = filtro + condicion
		END IF
	NEXT
END IF


Parent.TriggerEvent("ue_listar")
end event

type pb_borrar from upb_papelera within w_int_toma_inventario_compras
integer x = 1481
integer y = 1208
integer width = 183
integer height = 160
integer taborder = 20
end type

event clicked;String   var_almacen
Datetime var_fecha
Integer  registro,opcion
long     lineas_actualizadas

registro = dw_tomas.GetRow()
If registro > 0 Then
	var_almacen = dw_tomas.GetItemString(registro,"almacen")
	var_fecha   = dw_tomas.GetItemDatetime(registro,"fecha_inventario")
	opcion = MessageBox("Proceso de borrado" ,"¿Desea borrar la toma seleccionada?",Question!,YesNo!,2)
	If opcion = 1 THEN
		SELECT count(*)
		INTO   :lineas_actualizadas
		FROM   com_toma_inventario  
		WHERE (com_toma_inventario.empresa          = :codigo_empresa)
		AND   (com_toma_inventario.fecha_inventario = :var_fecha) 
		AND   (com_toma_inventario.almacen          = :var_almacen)
		AND   (com_toma_inventario.actualizado      = 'S');
		
		If IsNull(lineas_actualizadas) Then lineas_actualizadas = 0
		IF lineas_actualizadas > 0 Then
			MessageBox("No se puede Borrar" ,"Se han actualizado lineas de inventario a esta toma",Exclamation!,Ok!,1)			
		ELSE
			DELETE FROM com_toma_inventario
			WHERE (com_toma_inventario.empresa          = :codigo_empresa)
			AND   (com_toma_inventario.almacen          = :var_almacen)
			AND   (com_toma_inventario.fecha_inventario = :var_fecha );
			IF SQLCA.SQLCode<>0 THEN
				ROLLBACK using SQLCA;
				messagebox("Atención","Se ha producido un error al borrar la toma.~n"+sqlca.sqlerrtext)
			ELSE
				COMMIT using SQLCA;
			END IF
			dw_tomas.Retrieve(codigo_empresa)			
		END IF
	END IF
end if
end event

type ddlb_1 from dropdownlistbox within w_int_toma_inventario_compras
integer x = 1861
integer y = 1256
integer width = 594
integer height = 228
integer taborder = 70
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean vscrollbar = true
string item[] = {"Todos","Seleccionado"}
end type

type gb_1 from groupbox within w_int_toma_inventario_compras
integer x = 1833
integer y = 1160
integer width = 818
integer height = 204
integer taborder = 61
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

