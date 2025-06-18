killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch on primary first so the system tray stays on it 
primary=$(xrandr --query | grep " primary " | cut -d" " -f1)
MONITOR=$primary polybar --reload toph &

# Launch on all connected secondary monitors
secondary=$(xrandr --query | grep " connected" | grep -v "primary" | cut -d" " -f1)
for m in $secondary; do
  MONITOR=$m polybar --reload toph &
done

