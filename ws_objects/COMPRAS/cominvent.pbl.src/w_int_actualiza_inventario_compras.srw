$PBExportHeader$w_int_actualiza_inventario_compras.srw
forward
global type w_int_actualiza_inventario_compras from w_int_con_empresa
end type
type st_2 from statictext within w_int_actualiza_inventario_compras
end type
type em_periodo from u_em_campo within w_int_actualiza_inventario_compras
end type
type dw_1 from datawindow within w_int_actualiza_inventario_compras
end type
type cb_2 from u_boton within w_int_actualiza_inventario_compras
end type
type pb_1 from upb_salir within w_int_actualiza_inventario_compras
end type
end forward

global type w_int_actualiza_inventario_compras from w_int_con_empresa
integer width = 2903
integer height = 1652
string icon = "Application!"
st_2 st_2
em_periodo em_periodo
dw_1 dw_1
cb_2 cb_2
pb_1 pb_1
end type
global w_int_actualiza_inventario_compras w_int_actualiza_inventario_compras

type variables
DataStore inventario
end variables

forward prototypes
public function boolean f_entrada (long arg_linea)
end prototypes

public function boolean f_entrada (long arg_linea);// Contador de movimiento y orden de lineas de  ubicacion
Dec contador_nummov,contador_orden 
str_comlinubicahis ubihis
str_comlinubica    ubi
str_commovhis      mov
long x1
dec grabado,salir
string cur_mp
// Valor de controles funcionamiento
dec bien = 0
//------------------------------------------------------------------------
// Valores fijos para todos los casos
//------------------------------------------------------------------------
ubihis.usuario       = nombre_usuario
mov.usuario          = nombre_usuario
ubihis.empresa       = codigo_empresa
ubihis.fecha         = inventario.object.fecha_inventario[arg_linea]
ubihis.f_alta        = DateTime(Today(),now())
ubihis.anyo          = year(date(ubihis.fecha))
ubihis.almacen       = inventario.object.almacen[arg_linea]
ubihis.mp		      = inventario.object.mp[arg_linea]
ubihis.calidad       = inventario.object.calidad[arg_linea]
ubihis.observaciones = inventario.object.observaciones[arg_linea]
ubihis.tipomov       = "2"
ubihis.precio        = inventario.object.precio[arg_linea]
if isnull(ubihis.precio) then ubihis.precio = 0
mov.precio           = ubihis.precio
ubi.precio           = ubihis.precio
ubihis.familia       = inventario.object.familia[arg_linea]
ubihis.tipo_unidad   = inventario.object.tipo_unidad[arg_linea]
ubihis.envase        = inventario.object.envase_toma[arg_linea]
mov.envase           = ubihis.envase
ubi.empresa          = ubihis.empresa
ubi.almacen          = ubihis.almacen
ubi.mp		         = ubihis.mp
ubi.familia          = ubihis.familia
ubi.calidad          = ubihis.calidad
ubi.tipo_unidad      = ubihis.tipo_unidad
ubi.f_alta           = ubihis.fecha
// Valor movimiento historico
mov.empresa          = ubihis.empresa
mov.almacen          = ubihis.almacen
mov.mp		         = ubihis.mp
mov.familia          = ubihis.familia
mov.calidad          = ubihis.calidad
mov.tipo_unidad      = ubihis.tipo_unidad
mov.f_alta           = DateTime(Today(),now())
mov.anyo             = ubihis.anyo
//****
mov.origen           = ""
mov.fechmov          = ubihis.fecha
mov.tipomov          = ubihis.tipomov
mov.cantidade        = inventario.object.existencias_reales[arg_linea] - inventario.object.existencias_toma[arg_linea]
mov.cantidads        = 0
SetNull(mov.codtercero)
setnull(mov.numdoc)
mov.situacion        = "N"
mov.observaciones    = ubihis.observaciones
// Variable utilizada para montaje observaciones en lineas de ubicacion
String var_observaciones
//-------------------------------------------------------------------
contador_nummov   = f_comparam_nummov(codigo_empresa,mov.anyo)
contador_orden    = f_comparam_numorden(codigo_empresa,ubihis.anyo)
mov.nummov        = contador_nummov
ubihis.nummov     = contador_nummov
ubihis.orden      = contador_orden
ubihis.zona       = inventario.object.zona[arg_linea]
ubihis.fila       = inventario.object.fila[arg_linea]
ubihis.altura     = inventario.object.altura[arg_linea]
ubihis.cantidade  = inventario.object.existencias_reales[arg_linea] - inventario.object.existencias_toma[arg_linea]
ubihis.orden      = contador_orden
ubihis.nummov     = contador_nummov
ubihis.observaciones  = mov.observaciones
ubihis.f_alta     = DateTime(Today(),now())
ubihis.usuario    = nombre_usuario
ubihis.ubicacion  = inventario.object.ubicacion[arg_linea]
ubihis.cantidads  = 0
ubi.zona          = ubihis.zona
ubi.fila          = ubihis.fila
ubi.altura        = ubihis.altura
ubi.existencias   = ubihis.cantidade
ubi.ubicacion     = ubihis.ubicacion
//------------------------------------------------------------------
// Inserto en el historico de lineas de ubicacion por movimiento
//------------------------------------------------------------------
IF Not f_insert_comlinubicahis(ubihis) Then  bien = 1
//-----------------------------------------------------------------------
// Variables para cargar el cursor
//-----------------------------------------------------------------------
String cur_empresa,cur_almacen
dec    cur_pedido,cur_linea,cur_anyo,cur_precio
decimal{4}  cur_existencias
string cur_referencia,cur_ubicacion,cur_tipo_pallet

//----------------------------------------------------------
// Busco si hay linea este articulo
//---------------------------------------------------------
dec    registros
String sel
DataStore dw_proceso 
Sel = " SELECT   linea,existencias  " + &
		" FROM     comlinubica  " + &
		" WHERE    comlinubica.empresa    = '"+ codigo_empresa  + "'" +&
		" AND      comlinubica.ubicacion  = '"+ ubi.ubicacion + "'" +&
		" AND      comlinubica.mp = '"+ ubi.mp + "'" +&
		" AND      comlinubica.calidad = '"+ ubi.calidad + "'" 		

dw_proceso = f_cargar_cursor2(sel)
registros = dw_proceso.RowCount()
grabado=0
salir  =0
IF registros > 0 THEN
	FOR x1 = 1 To registros
		cur_empresa       = codigo_empresa
		cur_almacen       = f_almacen_ubicacion(ubi.ubicacion)
		cur_ubicacion     = ubi.ubicacion
		cur_mp    			= ubi.mp	
		cur_existencias   = dw_proceso.GetItemNumber(x1,"existencias")
		cur_linea         = dw_proceso.GetItemNumber(x1,"linea")
//		cur_precio        = dw_proceso.GetItemNumber(x1,"precio")
//		if isnull(cur_precio) then cur_precio = 0		
//		if cur_precio = ubi.precio then
			if cur_existencias + ubi.existencias >= 0 then
				grabado = 1
				ubi.existencias = ubi.existencias + cur_existencias
				UPDATE comlinubica  
				SET    existencias   = :ubi.existencias,   
						 f_alta        = :ubi.f_alta
				WHERE  comlinubica.empresa   = :ubi.empresa 
				AND    comlinubica.ubicacion = :ubi.ubicacion 
				AND    comlinubica.linea     = :cur_linea  USING SQLCA;
				
				IF SQLCA.SQLCode<>0 THEN  bien=1
				EXIT
			end if
//		end if
	NEXT
END IF
IF grabado = 0 THEN
	if ubi.existencias >= 0 then
		cur_linea=0
		SELECT  max(comlinubica.linea)  INTO :cur_linea FROM comlinubica  
		WHERE   comlinubica.empresa   = :ubi.empresa 
		AND     comlinubica.ubicacion = :ubi.ubicacion;
		IF IsNull(cur_linea) or trim(string(cur_linea))="" THEN
			cur_linea = 0 
		END IF
		cur_linea=cur_linea+1
		ubi.linea=cur_linea
		SetNull(ubi.observaciones)
		IF NOT f_insert_comlinubica(ubi) Then  bien=1	
	else
		bien = 1
		messagebox(f_nombre_mprima(codigo_empresa,ubi.mp),"Sin Stock para realizar la salida.")
	end if
END IF
//-----------------------Fin Grabación Lineas de Ubicacion--------------

// Grabar el movimiento en el historico por el total de existencias
IF NOT f_insert_commovhis(mov) Then
	MessageBox("Error en proceso","Grabando commovhis",Exclamation!, OK!,1)
	bien=1
END IF
IF NOT f_actualiza_nummov_compras(mov.empresa,mov.anyo,mov.nummov) THEN
	bien=1
END IF
IF NOT f_actualiza_numorden_compras(ubihis.empresa,ubihis.anyo,ubihis.orden) THEN
	bien=1
END IF

CHOOSE CASE bien
	CASE 1
		return false
	CASE 0
		return true
END CHOOSE


end function

event open;call super::open;istr_parametros.s_titulo_ventana="Proceso actualización inventarios de compras"
This.title = istr_parametros.s_titulo_ventana
dw_1.settransobject(SQLCA)
dw_1.SetRowFocusIndicator(Hand!)		// Use hand for focus indicator
em_periodo.text = String(year(today()))
dw_1.Retrieve(codigo_empresa,Integer(em_periodo.text))




end event

on w_int_actualiza_inventario_compras.create
int iCurrent
call super::create
this.st_2=create st_2
this.em_periodo=create em_periodo
this.dw_1=create dw_1
this.cb_2=create cb_2
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.em_periodo
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.pb_1
end on

on w_int_actualiza_inventario_compras.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_2)
destroy(this.em_periodo)
destroy(this.dw_1)
destroy(this.cb_2)
destroy(this.pb_1)
end on

event activate;call super::activate;w_int_actualiza_inventario_compras = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_actualiza_inventario_compras
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_actualiza_inventario_compras
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_actualiza_inventario_compras
end type

type st_2 from statictext within w_int_actualiza_inventario_compras
integer y = 180
integer width = 274
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Periodo"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_periodo from u_em_campo within w_int_actualiza_inventario_compras
integer x = 325
integer y = 164
integer taborder = 10
maskdatatype maskdatatype = numericmask!
string mask = "####"
end type

on modified;call u_em_campo::modified;dw_1.Retrieve(codigo_empresa,Integer(em_periodo.text))
end on

type dw_1 from datawindow within w_int_actualiza_inventario_compras
integer x = 585
integer y = 164
integer width = 777
integer height = 640
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_int_actualiza_inventario_compras1"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

on losefocus;This.BorderStyle=StyleRaised!
end on

on getfocus;This.BorderStyle=StyleLowered!
end on

type cb_2 from u_boton within w_int_actualiza_inventario_compras
integer x = 1367
integer y = 164
integer width = 389
integer height = 152
integer taborder = 30
string text = "&Actualizar"
end type

event clicked;long indice,total,var_linea
String    sel,var_ubicacion
DateTime  fecha,var_fecha_actualizado

IF MessageBox("Proceso Actualizacion","¿Desea Actualizar el Inventario?",Question!,YesNo!,2) = 1 Then	
	fecha = dw_1.GetItemDateTime(dw_1.GetRow(),"fecha_inventario")
	
	sel = " Select * from com_toma_inventario "+&
			" Where empresa   = '"+ codigo_empresa + "'"+&
			" And   fecha_inventario = '" +STring(datetime(Date(string(fecha,"yyyy-mm-dd"))))+"'"+&
			" And   actualizado = 'N' "+&
			" And   existencias_toma <> existencias_reales "
			
	//inventario = f_cargar_cursor(sel)
	f_cargar_cursor_nuevo(sel, inventario)
	total      = inventario.RowCount()
	IF total = 0 Then 
		f_mensaje("Proceso Inventario ","Inventario Inexistente o actualizado")
	else
		IF Not(f_bloquear_almacen_compras(Parent.title)) Then
			for indice = 1 to total
				if f_entrada(indice) then
					var_linea     = inventario.object.linea[indice]
					var_ubicacion = inventario.object.ubicacion[indice]
					var_fecha_actualizado = datetime(today())
					
					update com_toma_inventario
					set    actualizado = 'S',
							 fecha_actualizado = :var_fecha_actualizado
					where  empresa          = :codigo_empresa
					and    linea            = :var_linea
					and    ubicacion        = :var_ubicacion
					and    fecha_inventario = :fecha;
					if sqlca.sqlcode <> 0 then
						rollback;
						messagebox("Error","Al marcar la linea como actualizada.")
					else
						commit;
					end if
				else
					rollback;
				end if
			next
			f_desbloquear_almacen_compras(Parent.title)
		end if	
	messagebox("Atención","Proceso finalizado")
	END IF
	destroy inventario
end if

end event

type pb_1 from upb_salir within w_int_actualiza_inventario_compras
integer x = 2706
integer y = 36
integer width = 119
integer height = 116
integer taborder = 0
boolean bringtotop = true
end type

